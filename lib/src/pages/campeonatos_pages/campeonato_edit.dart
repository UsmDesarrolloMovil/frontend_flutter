import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class CampeonatoEdit extends StatelessWidget {
  final int idCampeonato;
  const CampeonatoEdit({super.key, required this.idCampeonato});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      showBackArrow: true,
      body: Center(
        child: Text('Editar el campeonato con id $idCampeonato'),
      ),
    );
  }
}
