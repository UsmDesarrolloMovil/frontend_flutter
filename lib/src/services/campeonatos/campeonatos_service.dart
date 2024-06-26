import 'package:dio/dio.dart';

import 'package:esports_app/config/config.dart';

class CampeonatoService {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  Future<List<dynamic>> getAll() async {
    final response = await dio.get('/campeonatos/list');

    return response.data;
  }

  Future<dynamic> getById(int idCampeonato) async {
    final response = await dio.get('/campeonatos/list/$idCampeonato');

    return response.data;
  }

  Future<List<dynamic>> getEquipos(int idCampeonato) async {
    final response = await dio.get('/campeonatos/$idCampeonato/equipos');

    return response.data;
  }

  Future<List<dynamic>> getPartidos(int idCampeonato) async {
    final response = await dio.get('/campeonatos/$idCampeonato/partidos');

    return response.data;
  }

  Future<dynamic> getPartido(int idPartido) async {
    final response = await dio.get('/partidos/$idPartido');

    return response.data;
  }

  Future<dynamic> editPartido(Map<String, dynamic> partidoData) async {
    final response = await dio.post('/partido/actualizar', data: partidoData);

    return response.data;
  }

  Future<void> deletePartido(int idPartido) async {
    await dio.delete('/partidos/$idPartido');
  }

  Future<void> createPartido(Map<String, dynamic> partidoData) async {
    await dio.post('/partidos', data: partidoData);
  }

  Future<void> createCampeonato(Map<String, dynamic> campeonatoData) async {
    await dio.post('/campeonatos', data: campeonatoData);
  }

  Future<void> deleteCampeonato(int id) async {
    await dio.delete('/campeonatos/$id');
  }

  Future<void> updateCampeonato(
      int idCampeonato, Map<String, dynamic> campeonatoData) async {
    await dio.put('/campeonatos/$idCampeonato', data: campeonatoData);
  }
}
