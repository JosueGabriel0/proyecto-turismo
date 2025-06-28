class UbicacionDto {
  final double lat;
  final double lng;
  final String titulo;
  final String tipo;
  final String descripcion;
  final String imagen;

  UbicacionDto({
    required this.lat,
    required this.lng,
    required this.titulo,
    required this.tipo,
    required this.descripcion,
    required this.imagen,
  });

  factory UbicacionDto.fromJson(Map<String, dynamic> json) {
    return UbicacionDto(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      titulo: json['titulo'] as String,
      tipo: json['tipo'] as String,
      descripcion: json['descripcion'] as String,
      imagen: json['imagen'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'titulo': titulo,
      'tipo': tipo,
      'descripcion': descripcion,
      'imagen': imagen,
    };
  }
}