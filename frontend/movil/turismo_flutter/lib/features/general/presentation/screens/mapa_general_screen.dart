import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa general")),
      body: MapWidget(
        key: const ValueKey("generalMap"),
        styleUri: MapboxStyles.MAPBOX_STREETS,
        onMapCreated: _onMapCreated,
      ),
    );
  }

  void _onMapCreated(MapboxMap controller) async {
    _mapboxMap = controller; // ✅ Primero se asigna

    // Obtener manejador de anotaciones
    _annotationManager = await _mapboxMap!.annotations.createPointAnnotationManager();

    // Centrar el mapa en el primer punto si existe
    if (widget.ubicaciones.isNotEmpty) {
      final primera = widget.ubicaciones.first;
      await _mapboxMap!.setCamera(CameraOptions(
        center: Point(coordinates: Position(primera['lng'], primera['lat'])),
        zoom: 12,
      ));
    }

    final markerImage = await loadHQMarkerImage();

    for (final lugar in widget.ubicaciones) {
      final annotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: Position(lugar['lng'], lugar['lat'])),
        image: markerImage,
        iconSize: 1.0,
      );

      final annotation = await _annotationManager!.create(annotationOptions);
      _marcadoresInfo[annotation.id] = lugar;
    }

    // Listener global para clic en marcadores
    _annotationManager!.addOnPointAnnotationClickListener(
      MiListener(context, _marcadoresInfo),
    );
  }

  Future<Uint8List> loadHQMarkerImage() async {
    final byteData = await rootBundle.load("assets/images/marker_red.png");
    return byteData.buffer.asUint8List();
  }
}

class MiListener implements OnPointAnnotationClickListener {
  final BuildContext context;
  final Map<String, Map<String, dynamic>> info;

  MiListener(this.context, this.info);

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    final lugar = info[annotation.id];
    if (lugar != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(lugar['titulo'] ?? 'Ubicación'),
          content: Text('Lat: ${lugar['lat']}, Lng: ${lugar['lng']}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cerrar"),
            ),
          ],
        ),
      );
    }
  }
}