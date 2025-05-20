class CategoriaDto {
  final String nombre;
  final String descripcion;

  CategoriaDto({
    required this.nombre,
    required this.descripcion,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  factory CategoriaDto.fromJson(Map<String, dynamic> json) {
    return CategoriaDto(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }
}
