import 'package:dio/dio.dart';

import 'package:esports_app/config/config.dart';

class EquipoService {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  Future<List<dynamic>> getAll() async {
    final response = await dio.get('/equipos/list');
    return response.data;
  }

  Future<dynamic> getById(int idEquipo) async {
    final response = await dio.get('/equipos/list/$idEquipo');

    return response.data;
  }

  Future<Map<String, dynamic>> getPartidos(int idEquipo) async {
    final response = await dio.get('/equipos/$idEquipo/partidos');

    return response.data;
  }

  Future<List<dynamic>> getJugadoresEquipo(int idEquipo) async {
    final response = await dio.get('/equipos/$idEquipo/jugadores');
    return response.data;
  }

  Future<List<dynamic>> getEquiposCampeonato(int idCampeonato) async {
    final response = await dio.get('/campeonatos/$idCampeonato/equipos/');
    return response.data;
  }

  Future<void> updateEquipo(
      int idEquipo, Map<String, dynamic> equipoData) async {
    await dio.put('/equipos/$idEquipo', data: equipoData);
  }

  Future<void> createEquipo(Map<String, dynamic> equipoData) async {
    await dio.post('/equipos', data: equipoData);
  }

  Future<void> deleteEquipo(int id) async {
    await dio.delete('/equipos/$id');
  }

  Future<void> createJugadores(Map<String, dynamic> jugadorData) async {
    await dio.post('/jugadores', data: jugadorData);
  }

  Future<void> deleteJugador(int id) async {
    await dio.delete('/jugadores/$id');
  }
}
