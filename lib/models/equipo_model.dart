class EquipoModel {
  int id;
  String nombre;
  String juegos;
  String imgUrl;
  int puntos;

  EquipoModel({
    required this.id,
    required this.nombre,
    required this.juegos,
    required this.imgUrl,
    required this.puntos,
  });

  factory EquipoModel.fromApi(Map<String, dynamic> equipo) {
    return EquipoModel(
      id: equipo['id'],
      nombre: equipo['nombre'],
      juegos: equipo['juegos'],
      imgUrl: equipo['imagen_url'],
      puntos: equipo['puntos'] == null ? 0 : equipo['puntos'],
    );
  }

  List<String> get listarJuegos {
    return juegos.split(',');
  }
}
