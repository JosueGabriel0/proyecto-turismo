import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:permission_handler/permission_handler.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePageState2();
}

class _HomePageState2 extends State<HomePage2> {
  mp.MapboxMap? mapboxMapController;
  StreamSubscription? userPositionStream;

  mp.PointAnnotationManager? pointAnnotationManager;
  double? selectedLat;
  double? selectedLng;

  @override
  void initState() {
    super.initState();
    _setupPositionTracking();
    solicitarPermisoUbicacion();
  }

  @override
  void dispose() {
    userPositionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          mp.MapWidget(
            key: const ValueKey("mapWidget"),
            onMapCreated: _onMapCreated,
            styleUri: mp.MapboxStyles.DARK,
            onTapListener: _onTap, // ✅ Nuevo listener
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Card(
              elevation: 6,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Ubicación seleccionada:", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Latitud: ${selectedLat?.toStringAsFixed(6) ?? '-'}"),
                    Text("Longitud: ${selectedLng?.toStringAsFixed(6) ?? '-'}"),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedLat != null && selectedLng != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Ubicación guardada: $selectedLat, $selectedLng'),
                          ));
                        }
                      },
                      child: const Text("Guardar ubicación"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Nuevo método onTap usando MapContentGestureContext
  void _onTap(mp.MapContentGestureContext context) {
    final double lat = context.point.coordinates.lat.toDouble();
    final double lng = context.point.coordinates.lng.toDouble();

    print("OnTap coordinate: {$lng, $lat} "
        "point: x: ${context.touchPosition.x}, y: ${context.touchPosition.y}");

    setState(() {
      selectedLat = lat;
      selectedLng = lng;
    });

    _addMarker(lat, lng);
  }

  void _onMapCreated(mp.MapboxMap controller) async {
    setState(() {
      mapboxMapController = controller;
    });

    await mapboxMapController?.location.updateSettings(
      mp.LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
      ),
    );

    pointAnnotationManager =
    await mapboxMapController?.annotations.createPointAnnotationManager();
  }

  Future<void> _addMarker(double lat, double lng) async {
    if (pointAnnotationManager == null) return;

    await pointAnnotationManager!.deleteAll();

    final Uint8List imageData = await loadHQMarkerImage();
    final mp.PointAnnotationOptions pointAnnotationOptions = mp.PointAnnotationOptions(
      image: imageData,
      iconSize: 1,
      geometry: mp.Point(coordinates: mp.Position(lng, lat)),
    );

    pointAnnotationManager?.create(pointAnnotationOptions);
  }

  Future<void> _setupPositionTracking() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) return;
    }

    if (permission == gl.LocationPermission.deniedForever) return;

    gl.LocationSettings locationSettings = gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();
    userPositionStream =
        gl.Geolocator.getPositionStream(locationSettings: locationSettings).listen((gl.Position? position) {
          if (position != null && mapboxMapController != null) {
            mapboxMapController?.setCamera(
              mp.CameraOptions(
                zoom: 15,
                center: mp.Point(
                  coordinates: mp.Position(position.longitude, position.latitude),
                ),
              ),
            );
          }
        });
  }

  Future<void> solicitarPermisoUbicacion() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.location.request();
    }

    if (!status.isGranted) {
      print("Permiso de ubicación denegado o no disponible");
    }
  }

  Future<Uint8List> loadHQMarkerImage() async {
    var byteData = await rootBundle.load("assets/images/marker_red.png");
    return byteData.buffer.asUint8List();
  }
}