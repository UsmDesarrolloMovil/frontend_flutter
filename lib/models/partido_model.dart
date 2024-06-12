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
  int? equipoLocalId;
  int? equipoVisitanteId;

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
    this.equipoGanador,
    this.puntosLocal,
    this.puntosVisitante,
    this.equipoLocalId,
    this.equipoVisitanteId,
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
      equipoLocalId: partido['equipo_local_id'],
      equipoVisitanteId: partido['equipo_visitante_id'],
    );
  }
  factory PartidoModel.fromApiEdit(Map<String, dynamic> partido) {
    return PartidoModel(
      id: partido['id'],
      equipoLocal: partido['equipo_local']['nombre'],
      imagenLocal: partido['equipo_local']['imagen_url'],
      equipoVisitante: partido['equipo_visitante']['nombre'],
      imagenVisitante: partido['equipo_visitante']['imagen_url'],
      fecha: partido['fecha'],
      hora: partido['hora'],
      lugar: partido['lugar'],
      estado: partido['estado'],
      equipoGanador: partido['resultado']?['equipo_ganador_id'],
      puntosLocal: partido['resultado']?['puntos_local'],
      puntosVisitante: partido['resultado']?['puntos_visitante'],
      equipoLocalId: partido['equipo_local_id'],
      equipoVisitanteId: partido['equipo_visitante_id'],
    );
  }

  bool get isFinished {
    return estado == 1;
  }

  static estadoToString(int estado) {
    switch (estado) {
      case 0:
        return 'Pendiente';
      case 1:
        return 'Finalizado';
      case 2:
        return 'En Curso';
      default:
        return 'Pendiente';
    }
  }

  static int estadoToInt(String estado) {
    switch (estado) {
      case 'Pendiente':
        return 0;
      case 'Finalizado':
        return 1;
      case 'En Curso':
        return 2;
      default:
        return 1;
    }
  }
}
