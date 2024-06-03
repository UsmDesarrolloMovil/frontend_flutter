import 'package:go_router/go_router.dart';

import '../../src/pages/index.dart';
import '../../src/screens/index.dart';

final mainRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/campeonatos',
      builder: (context, state) => const CampeonatosScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final idCampeonato = state.pathParameters['id'] ?? '0';
            return CampeonatoById(id: int.parse(idCampeonato));
          },
        ),
        GoRoute(
          path: ':id/edit',
          builder: (context, state) {
            final idCampeonato = state.pathParameters['id'] ?? '0';
            return CampeonatoEdit(idCampeonato: int.parse(idCampeonato));
          },
        ),
        GoRoute(
          path: ':id/equipos',
          builder: (context, state) {
            final idCampeonato = state.pathParameters['id'] ?? '0';
            return CampeonatoEquipos(idCampeonato: int.parse(idCampeonato));
          },
        ),
        GoRoute(
          path: ':id/partidos',
          builder: (context, state) {
            final idCampeonato = state.pathParameters['id'] ?? '0';
            return CalendarioCampeonato(idCampeonato: int.parse(idCampeonato));
          },
        ),
        GoRoute(
          path: ':id/addEquipo',
          builder: (context, state) {
            final idCampeonato = state.pathParameters['id'] ?? '0';
            return AddEquipoToCampeonato(idCampeonato: int.parse(idCampeonato));
          },
        ),
        GoRoute(
          path: ':id/addPartido',
          builder: (context, state) {
            final idCampeonato = state.pathParameters['id'] ?? '0';
            return AddPartidoToCampeonato(
                idCampeonato: int.parse(idCampeonato));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/addCampeonato',
      builder: (context, state) => const AddCampeonato(),
    ),
    GoRoute(
      path: '/equipos',
      builder: (context, state) => const EquiposScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final idEquipo = state.pathParameters['id'] ?? '0';
            return EquipoById(id: int.parse(idEquipo));
          },
        ),
        GoRoute(
          path: ':id/partidos',
          builder: (context, state) {
            final idEquipo = state.pathParameters['id'] ?? '0';
            return EquiposPartidosById(idEquipo: int.parse(idEquipo));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/calendario',
      builder: (context, state) => const CalendarioScreen(),
    ),
    GoRoute(
      path: '/resultados',
      builder: (context, state) => const ResultadosScreen(),
    ),
  ],
);
