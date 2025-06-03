import 'package:turismo_flutter/features/admin/data/models/familia_response.dart';

class LugarResponse {
  int idLugar;
  String nombre;
  String descripcion;
  String direccion;
  String ciudad;
  String provincia;
  String pais;
  String latitud;
  String longitud;
  String? imagenUrl;
  List<FamiliaResponse?>? familias;
  String fechaCreacionLugar;
  String? fechaModificacionLugar;

  LugarResponse({
    required this.idLugar,
    required this.nombre,
    required this.descripcion,
    required this.direccion,
    required this.ciudad,
    required this.provincia,
    required this.pais,
    required this.latitud,
    required this.longitud,
    required this.imagenUrl,
    required this.familias,
    required this.fechaCreacionLugar,
    required this.fechaModificacionLugar,
  });

  factory LugarResponse.fromJson(Map<String, dynamic> json) {
    print("JSON lugar recibido: $json");
    return LugarResponse(
      idLugar: json['idLugar'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      direccion: json['direccion'],
      ciudad: json['ciudad'],
      provincia: json['provincia'],
      pais: json['pais'],
      latitud: json['latitud'].toString(),
      longitud: json['longitud'].toString(),
      imagenUrl: json['imagenUrl'],
      familias: json['familias'] != null
          ? (json['familias'] as List).map((e) => FamiliaResponse.fromJson(e)).toList()
          : null,
      fechaCreacionLugar: json['fechaCreacionLugar'],
      fechaModificacionLugar: json['fechaModificacionLugar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idLugar': idLugar,
      'nombre': nombre,
      'descripcion': descripcion,
      'direccion': direccion,
      'ciudad': ciudad,
      'provincia': provincia,
      'pais': pais,
      'latitud': latitud,
      'longitud': longitud,
      'imagenUrl': imagenUrl,
      'familias': familias?.map((e) => e?.toJson()).toList(),
      'fechaCreacionLugar': fechaCreacionLugar,
      'fechaModificacionLugar': fechaModificacionLugar,
    };
  }
}