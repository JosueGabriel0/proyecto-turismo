import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  mp.MapboxMap? mapboxMapController;

  StreamSubscription? userPositionStream;

  @override
  void initState(){
    super.initState();
    _setupPositionTracking();
    solicitarPermisoUbicacion();
  }

  @override
  void dispose(){
    userPositionStream?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mp.MapWidget(
        onMapCreated: _onMapCreated,
        styleUri: mp.MapboxStyles.DARK,
      ),
    );
  }

  void _onMapCreated(mp.MapboxMap controller,) async{
    setState(() {
      mapboxMapController = controller;
    });

    //Logic for displaying user position on map.
    mapboxMapController?.location.updateSettings(
      mp.LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
      ),
    );

    //Logic for adding custom annotations
    final pointAnnotationManager = await mapboxMapController?.annotations.createPointAnnotationManager();

    final Uint8List imageData = await loadHQMarkerImage();
    mp.PointAnnotationOptions pointAnnotationOptions = mp.PointAnnotationOptions(
      image: imageData,
      iconSize: 1,
      geometry: mp.Point(coordinates: mp.Position(-122.0312186, 37.33233141,),),
    );

    pointAnnotationManager?.create(
      pointAnnotationOptions,
    );
  }

  Future<void> _setupPositionTracking() async {
    bool serviceEnabled;
    gl.LocationPermission permission;

    serviceEnabled = await gl.Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    permission = await gl.Geolocator.checkPermission();
    if(permission == gl.LocationPermission.denied){
      permission = await gl.Geolocator.requestPermission();
      if(permission == gl.LocationPermission.denied){
        return Future.error('Location permissions are denied  ');
      }
    }

    if(permission == gl.LocationPermission.deniedForever){
      return Future.error('Location permissions are permanently denied, we cannot request permission');
    }

    gl.LocationSettings locationSettings = gl.LocationSettings(
      accuracy: gl.LocationAccuracy.high,
      distanceFilter: 100,
    );

    userPositionStream?.cancel();
    userPositionStream =
        gl.Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen(
                (
              gl.Position? position,
              ){
                  if(position != null && mapboxMapController != null){
                    mapboxMapController?.setCamera(
                      mp.CameraOptions(
                        zoom: 15,
                          center: mp.Point(
                              coordinates: mp.Position(
                                position.longitude,
                                position.latitude,
                              ),
                          ),
                      ),
                    );
                  }
                },
        );
  }

  Future<void> solicitarPermisoUbicacion() async {
    var status = await Permission.location.status;

    if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      print("Permiso de ubicación concedido");
    } else {
      print("Permiso de ubicación denegado o no disponible");
    }
  }

  Future<Uint8List> loadHQMarkerImage() async {
    var byteData = await rootBundle.load("assets/images/marker_red.png",);
    return byteData.buffer.asUint8List();
  }

}
