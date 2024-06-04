class CampeonatoModel {
  int id;
  String nombre;
  String fechaInicio;
  String fechaTermino;
  String premios;
  String detalles;
  String imgUrl;
  String reglas;
  CampeonatoModel({
    required this.id,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaTermino,
    required this.premios,
    required this.detalles,
    required this.imgUrl,
    required this.reglas,
  });

  factory CampeonatoModel.fromApi(Map<String, dynamic> campeonato) {
    return CampeonatoModel(
        id: campeonato['id'],
        nombre: campeonato['nombre'],
        fechaInicio: campeonato['fecha_inicio'],
        fechaTermino: campeonato['fecha_fin'],
        premios: campeonato['premios'],
        detalles: campeonato['detalles'],
        imgUrl: campeonato['imagen_url'],
        reglas: campeonato['reglas']);
  }
}
