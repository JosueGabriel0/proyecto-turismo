import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_mapa.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/foto_rectangulo_widget.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapaGeneralScreen extends StatefulWidget {
  final List<Map<String, dynamic>> ubicaciones; // Cada elemento debe tener lat, lng y un título

  const MapaGeneralScreen({super.key, required this.ubicaciones});

  @override
  State<MapaGeneralScreen> createState() => _MapaGeneralScreenState();
}

class _MapaGeneralScreenState extends State<MapaGeneralScreen> {

  final Map<String, Map<String, dynamic>> _marcadoresInfo = {};

  MapboxMap? _mapboxMap;
  PointAnnotationManager? _annotationManager;

  PolylineAnnotationManager? _lineManager;
  PolylineAnnotation? _rutaPolyline;

  Future<void> _solicitarPermisoUbicacion() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.location.request();
    }

    if (!status.isGranted) {
      debugPrint("Permiso de ubicación denegado");
    }
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

    await _mapboxMap?.setCamera(CameraOptions(
      center: Point(coordinates: Position(position.longitude, position.latitude)),
      zoom: 14,
    ));
  }

  Future<List<Position>> obtenerRuta({
    required double origenLat,
    required double origenLng,
    required double destinoLat,
    required double destinoLng,
  }) async {
    final accessToken = 'pk.eyJ1Ijoiam9zdWUyMDAzIiwiYSI6ImNtYWI5eHB4aDFrOXQyam9pY2toMHg1dTEifQ.mioI8UDDcUa9pqKXIsEC6A';

    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/driving/$origenLng,$origenLat;$destinoLng,$destinoLat'
          '?geometries=geojson&access_token=$accessToken',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coordinates = data['routes'][0]['geometry']['coordinates'] as List;

      return coordinates.map<Position>((coord) {
        return Position(coord[0], coord[1]); // lng, lat
      }).toList();
    } else {
      throw Exception('Error al obtener la ruta: ${response.body}');
    }
  }



  @override
  void initState() {
    super.initState();
    _solicitarPermisoUbicacion();
  }

  void _onMapCreated(MapboxMap controller) async {
    _mapboxMap = controller;

    _lineManager = await _mapboxMap!.annotations.createPolylineAnnotationManager();

    // 👇 Habilitar el punto azul de ubicación
    await _mapboxMap?.location.updateSettings(LocationComponentSettings(
      enabled: true,
      pulsingEnabled: true, // Opcional: para efecto de pulso
      pulsingColor: Colors.blueAccent.value,
      showAccuracyRing: true,
    ));

    _annotationManager = await _mapboxMap!.annotations.createPointAnnotationManager();

    if (widget.ubicaciones.isNotEmpty) {
      final primera = widget.ubicaciones.first;
      await _mapboxMap!.setCamera(CameraOptions(
        center: Point(coordinates: Position(primera['lng'], primera['lat'])),
        zoom: 12,
      ));
    }

    final redMarker = await loadMarkerImage("assets/images/marker_red.png");
    final greenMarker = await loadMarkerImage("assets/images/marker_green.png");

    for (final lugar in widget.ubicaciones) {
      final tipo = lugar['tipo'] ?? 'lugar';

      final markerImage = tipo == 'emprendimiento' ? greenMarker : redMarker;

      final iconSize = tipo == 'emprendimiento' ? 0.2 : 1.3;

      final annotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: Position(lugar['lng'], lugar['lat'])),
        image: markerImage,
        iconSize: iconSize,
      );

      final annotation = await _annotationManager!.create(annotationOptions);
      _marcadoresInfo[annotation.id] = lugar;
    }

    _annotationManager!.addOnPointAnnotationClickListener(
      MiListener(context, _marcadoresInfo, mostrarRuta),
    );
  }

  Future<Uint8List> loadMarkerImage(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  Future<void> mostrarRuta(double destinoLat, double destinoLng) async {
    try {
      final pos = await gl.Geolocator.getCurrentPosition();

      final puntos = await obtenerRuta(
        origenLat: pos.latitude,
        origenLng: pos.longitude,
        destinoLat: destinoLat,
        destinoLng: destinoLng,
      );

      final geometry = LineString(coordinates: puntos);

      await _lineManager?.deleteAll(); // Limpia ruta anterior

      _rutaPolyline = await _lineManager?.create(PolylineAnnotationOptions(
        geometry: geometry,
        lineColor: const Color(0xFF3B9DDD).value,
        lineWidth: 5,
      ));

      // Opcional: centrar cámara en la ruta
      await _mapboxMap?.setCamera(CameraOptions(
        center: Point(coordinates: Position(destinoLng, destinoLat)),
        zoom: 13,
      ));
    } catch (e) {
      debugPrint('Error al mostrar ruta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa general")),
      body: Stack(
        children: [
          MapWidget(
            key: const ValueKey("generalMap"),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/marker_green.png", width: 24),
                  const SizedBox(width: 5),
                  const Text("Emprendimientos"),
                  const SizedBox(width: 15),
                  Image.asset("assets/images/marker_red.png", width: 24),
                  const SizedBox(width: 5),
                  const Text("Lugares"),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: FloatingActionButton(
              heroTag: 'gps_button',
              mini: true,
              backgroundColor: Colors.white,
              onPressed: _centrarEnUbicacionActual,
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}

class MiListener implements OnPointAnnotationClickListener {
  final BuildContext context;
  final Map<String, Map<String, dynamic>> info;
  final void Function(double, double) onRutaSolicitada;

  MiListener(this.context, this.info, this.onRutaSolicitada);

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    final lugar = info[annotation.id];
    if (lugar != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      lugar['titulo'] ?? 'Ubicación',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FotoRectanguloMapa(
                    fileName: lugar['imagen'] ?? '',
                    height: 120,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 10),
                  if (lugar['descripcion'] != null)
                    Text(
                      lugar['descripcion'],
                      style: const TextStyle(fontSize: 14),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Lat: ${lugar['lat']}, Lng: ${lugar['lng']}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onRutaSolicitada(lugar['lat'], lugar['lng']); // ✅ LLAMADA CORRECTA
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Mejor ruta'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}