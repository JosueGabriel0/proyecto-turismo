class CategoriaDto {
  final String nombre;
  final String descripcion;
  final String nombreFamilia;

  CategoriaDto({
    required this.nombre,
    required this.descripcion,
    required this.nombreFamilia
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'nombreFamilia': nombreFamilia,
    };
  }

  factory CategoriaDto.fromJson(Map<String, dynamic> json) {
    return CategoriaDto(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      nombreFamilia: json['nombreFamilia'],
    );
  }
}
