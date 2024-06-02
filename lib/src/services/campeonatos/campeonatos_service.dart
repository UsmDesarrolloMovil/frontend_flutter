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
}
