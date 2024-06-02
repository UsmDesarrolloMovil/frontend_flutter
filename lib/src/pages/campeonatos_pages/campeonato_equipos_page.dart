import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class CampeonatoEquipos extends StatelessWidget {
  final int idCampeonato;
  const CampeonatoEquipos({super.key, required this.idCampeonato});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      showBackArrow: true,
      body: Center(
        child: Text('Equipos Campeonato $idCampeonato'),
      ),
    );
  }
}
