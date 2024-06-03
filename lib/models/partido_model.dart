class PartidoModel {
  int id;
  String equipoLocal;
  String imagenLocal;
  String equipoVisitante;
  String imagenVisitante;
  String fecha;
  String hora;
  String lugar;
  int estado; // 0 -> Pendiente , 1 -> Terminado, 2 -> EnCurso
  int? equipoGanador;
  int? puntosLocal;
  int? puntosVisitante;

  PartidoModel({
    required this.id,
    required this.equipoLocal,
    required this.imagenLocal,
    required this.equipoVisitante,
    required this.imagenVisitante,
    required this.fecha,
    required this.hora,
    required this.lugar,
    required this.estado,
    required this.equipoGanador,
    required this.puntosLocal,
    required this.puntosVisitante,
  });

  factory PartidoModel.fromApi(Map<String, dynamic> partido) {
    return PartidoModel(
      id: partido['id'],
      equipoLocal: partido['equipo_local'],
      imagenLocal: partido['imagen_local'],
      equipoVisitante: partido['equipo_visitante'],
      imagenVisitante: partido['imagen_visitante'] ?? 0,
      fecha: partido['fecha'],
      hora: partido['hora'],
      lugar: partido['lugar'],
      estado: partido['estado'],
      equipoGanador: partido['equipo_ganador_id'],
      puntosLocal: partido['puntos_local'],
      puntosVisitante: partido['puntos_visitante'],
    );
  }

  bool get isFinished {
    return estado == 1;
  }
}
