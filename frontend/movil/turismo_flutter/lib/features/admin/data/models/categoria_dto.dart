class CategoriaDto {
  final String nombre;
  final String nombreLugar;

  CategoriaDto({
    required this.nombre,
    required this.nombreLugar,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'nombreLugar': nombreLugar,
    };
  }

  factory CategoriaDto.fromJson(Map<String, dynamic> json) {
    return CategoriaDto(
      nombre: json['nombre'],
      nombreLugar: json['nombreLugar'],
    );
  }
}
