import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class EquiposPartidosById extends StatelessWidget {
  const EquiposPartidosById({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      showBackArrow: true,
      body: FutureBuilder(
        future: future,
        builder: builder,
      ),
    );
  }
}
