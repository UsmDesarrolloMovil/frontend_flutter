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
