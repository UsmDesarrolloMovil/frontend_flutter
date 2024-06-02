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
          path: ':id/equipos',
          builder: (context, state) {
            final idCampeonato = state.pathParameters['id'] ?? '0';
            return CampeonatoEquipos(idCampeonato: int.parse(idCampeonato));
          },
        ),
      ],
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
