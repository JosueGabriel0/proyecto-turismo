class ServicioTuristicoEmprendedorDto {
  final int idServicio;
  final String nombre;
  final String descripcion;
  final double precioUnitario;
  final String tipoServicio; // Puedes convertirlo en enum si lo deseas
  final String nombreEmprendimiento;

  ServicioTuristicoEmprendedorDto({
    required this.idServicio,
    required this.nombre,
    required this.descripcion,
    required this.precioUnitario,
    required this.tipoServicio,
    required this.nombreEmprendimiento,
  });

  factory ServicioTuristicoEmprendedorDto.fromJson(Map<String, dynamic> json) {
    return ServicioTuristicoEmprendedorDto(
      idServicio: json['idServicio'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precioUnitario: (json['precioUnitario'] as num).toDouble(),
      tipoServicio: json['tipoServicio'],
      nombreEmprendimiento: json['nombreEmprendimiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idServicio': idServicio,
      'nombre': nombre,
      'descripcion': descripcion,
      'precioUnitario': precioUnitario,
      'tipoServicio': tipoServicio,
      'nombreEmprendimiento': nombreEmprendimiento,
    };
  }
}