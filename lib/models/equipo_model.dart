class EquipoModel {
  int id;
  String nombre;
  String juegos;
  String imgUrl;
  int puntos;
  List<String> jugadores;

  EquipoModel({
    required this.id,
    required this.nombre,
    required this.juegos,
    required this.imgUrl,
    required this.puntos,
    required this.jugadores,
  });

  factory EquipoModel.fromApi(Map<String, dynamic> equipo) {
    return EquipoModel(
      id: equipo['id'],
      nombre: equipo['nombre'],
      juegos: equipo['juegos'],
      imgUrl: equipo['imagen_url'],
      puntos: equipo['puntos'] ?? 0,
      jugadores: List<String>.from(equipo['jugadores'] ?? []),
    );
  }

  List<String> get listarJuegos {
    return juegos.split(',');
  }
}
