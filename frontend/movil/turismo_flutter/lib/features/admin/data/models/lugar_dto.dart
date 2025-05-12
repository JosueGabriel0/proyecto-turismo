class LugarDto{
  final String nombre;
  final String descripcion;
  final String direccion;
  final String ciudad;
  final String provincia;
  final String pais;
  final String latitud;
  final String longitud;

  LugarDto({
    required this.nombre,
    required this.descripcion,
    required this.direccion,
    required this.ciudad,
    required this.provincia,
    required this.pais,
    required this.latitud,
    required this.longitud,
});

  Map<String, dynamic> toJson(){
    return{
      "nombre": nombre,
      "descripcion": descripcion,
      "direccion": direccion,
      "ciudad": ciudad,
      "provincia": provincia,
      "pais": pais,
      "latitud": latitud,
      "longitud": longitud,
    };
  }
}