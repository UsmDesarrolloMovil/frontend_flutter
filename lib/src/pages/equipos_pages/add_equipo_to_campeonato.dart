import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class AddEquipoToCampeonato extends StatelessWidget {
  final int idCampeonato;
  const AddEquipoToCampeonato({super.key, required this.idCampeonato});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      showBackArrow: true,
      body: Center(
        child: Text('Añadir un equipo existente al campeonato: $idCampeonato'),
      ),
    );
  }
}
