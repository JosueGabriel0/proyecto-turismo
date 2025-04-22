class RolDto {
  final String nombre;

  RolDto({required this.nombre});

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
    };
  }
}