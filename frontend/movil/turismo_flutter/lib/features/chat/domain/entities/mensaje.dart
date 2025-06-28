import 'package:equatable/equatable.dart';

class Mensaje extends Equatable{
  final int? id;
  final String emisor;
  final String receptor;
  final String? texto;
  final String? archivo;
  final String tipo;       // Ej: "TEXTO", "IMAGEN", etc.
  final String? estado;    // Ej: "ENVIADO", "LEIDO", etc.
  final bool editado;
  final DateTime? fecha;
  final String? idTemporal;

  Mensaje({
    this.id,
    required this.emisor,
    required this.receptor,
    this.texto,
    this.archivo,
    required this.tipo,
    this.estado,
    this.editado = false,
    this.fecha,
    this.idTemporal,
  });

  factory Mensaje.vacio() => Mensaje(
    id: null,
    idTemporal: null,
    emisor: '',
    receptor: '',
    texto: '',
    archivo: null,
    estado: '',
    tipo: 'TEXTO',
    fecha: DateTime.now(),
  );

  @override
  List<Object?> get props => [
    id,
    idTemporal,
    emisor,
    receptor,
    texto,
    archivo,
    estado,
    tipo,
    fecha?.millisecondsSinceEpoch, // 👈 importante para que detecte cambios
  ];
}

extension MensajeCopyWith on Mensaje {
  Mensaje copyWith({
    int? id,
    String? idTemporal,
    String? emisor,
    String? receptor,
    String? texto,
    String? archivo,
    String? estado,
    String? tipo,
    DateTime? fecha,
  }) {
    return Mensaje(
      id: id ?? this.id,
      idTemporal: idTemporal ?? this.idTemporal,
      emisor: emisor ?? this.emisor,
      receptor: receptor ?? this.receptor,
      texto: texto ?? this.texto,
      archivo: archivo ?? this.archivo,
      estado: estado ?? this.estado,
      tipo: tipo ?? this.tipo,
      fecha: fecha ?? this.fecha,
    );
  }
}