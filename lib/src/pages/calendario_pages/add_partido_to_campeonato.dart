import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class AddPartidoToCampeonato extends StatelessWidget {
  final int idCampeonato;
  const AddPartidoToCampeonato({super.key, required this.idCampeonato});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      showBackArrow: true,
      body: Center(
        child: Text('Añadir un partido al campeonato: $idCampeonato'),
      ),
    );
  }
}
