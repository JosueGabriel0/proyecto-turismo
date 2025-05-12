class FamiliaDto {
  final String nombre;
  final String descripcion;
  final String nombreLugar;

  FamiliaDto({
    required this.nombre,
    required this.descripcion,
    required this.nombreLugar
  });

  Map<String, dynamic> toJson(){
    return {
      "nombre": nombre,
      "descripcion": descripcion,
      "nombreLugar": nombreLugar,
    };
  }
}