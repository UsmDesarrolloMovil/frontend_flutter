import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class AddCampeonato extends StatelessWidget {
  const AddCampeonato({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientScaffold(
      showBackArrow: true,
      body: Center(
        child: Text('Añadir un Campeonato'),
      ),
    );
  }
}
