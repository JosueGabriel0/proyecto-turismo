class EmprendimientoDto {
  String nombre;
  String descripcion;
  String latitud;
  String longitud;
  int idFamiliaCategoria;

  EmprendimientoDto({
    required this.nombre,
    required this.descripcion,
    required this.latitud,
    required this.longitud,
    required this.idFamiliaCategoria,
  });

  factory EmprendimientoDto.fromJson(Map<String, dynamic> json) {
    return EmprendimientoDto(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      latitud: json['latitud'].toString(),
      longitud: json['longitud'].toString(),
      idFamiliaCategoria: json['idFamiliaCategoria'] is int
          ? json['idFamiliaCategoria']
          : int.parse(json['idFamiliaCategoria'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'latitud': latitud,
      'longitud': longitud,
      'idFamiliaCategoria': idFamiliaCategoria,
    };
  }
}