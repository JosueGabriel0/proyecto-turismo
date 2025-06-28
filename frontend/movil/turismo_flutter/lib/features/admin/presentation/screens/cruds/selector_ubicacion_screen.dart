import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:permission_handler/permission_handler.dart';

class SeleccionUbicacionScreen extends StatefulWidget {
  final double? latInicial;
  final double? lngInicial;

  const SeleccionUbicacionScreen({super.key, this.latInicial, this.lngInicial});

  @override
  State<SeleccionUbicacionScreen> createState() => _SeleccionUbicacionScreenState();
}

class _SeleccionUbicacionScreenState extends State<SeleccionUbicacionScreen> {
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
      appBar: AppBar(title: const Text("Seleccionar ubicación")),
      body: Stack(
        children: [
          mp.MapWidget(
            key: const ValueKey("mapWidget"),
            styleUri: mp.MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _onMapCreated,
            onTapListener: _onTap,
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
                          Navigator.pop(context, {'lat': selectedLat, 'lng': selectedLng});
                        }
                      },
                      child: const Text("Guardar ubicación"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100, // Asegúrate de que no choque con el Card de guardar
            right: 20,
            child: FloatingActionButton(
              heroTag: 'gps_button',
              mini: true,
              backgroundColor: Colors.white,
              onPressed: _centrarEnUbicacionActual,
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(mp.MapContentGestureContext context) {
    final lat = context.point.coordinates.lat.toDouble();
    final lng = context.point.coordinates.lng.toDouble();

    setState(() {
      selectedLat = lat;
      selectedLng = lng;
    });

    _addMarker(lat, lng);
  }

  void _onMapCreated(mp.MapboxMap controller) async {
    mapboxMapController = controller;

    // Cámara inicial con coordenadas iniciales si están definidas
    if (widget.latInicial != null && widget.lngInicial != null) {
      await mapboxMapController?.setCamera(
        mp.CameraOptions(
          center: mp.Point(coordinates: mp.Position(widget.lngInicial!, widget.latInicial!)),
          zoom: 14,
        ),
      );

      _addMarker(widget.latInicial!, widget.lngInicial!);
      selectedLat = widget.latInicial;
      selectedLng = widget.lngInicial;
    }

    await mapboxMapController?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    pointAnnotationManager = await mapboxMapController?.annotations.createPointAnnotationManager();
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
    final serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    var permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) return;
    }

    if (permission == gl.LocationPermission.deniedForever) return;

    final locationSettings = gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();
    userPositionStream = gl.Geolocator.getPositionStream(locationSettings: locationSettings).listen((gl.Position? position) {
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
      debugPrint("Permiso de ubicación denegado");
    }
  }

  Future<Uint8List> loadHQMarkerImage() async {
    final byteData = await rootBundle.load("assets/images/marker_red.png");
    return byteData.buffer.asUint8List();
  }

  Future<void> _centrarEnUbicacionActual() async {
    final serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    var permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) return;
    }

    if (permission == gl.LocationPermission.deniedForever) return;

    final position = await gl.Geolocator.getCurrentPosition();

    await mapboxMapController?.setCamera(
      mp.CameraOptions(
        center: mp.Point(coordinates: mp.Position(position.longitude, position.latitude)),
        zoom: 15,
      ),
    );
  }
}