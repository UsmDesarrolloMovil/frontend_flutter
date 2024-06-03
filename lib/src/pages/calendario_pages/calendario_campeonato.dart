import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/partido_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/partidos/card_partidos.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CalendarioCampeonato extends StatelessWidget {
  final int idCampeonato;
  const CalendarioCampeonato({
    super.key,
    required this.idCampeonato,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GradientScaffold(
      floatingActionButton: SlideInRight(
        delay: const Duration(seconds: 1),
        child: FloatingActionButton(
          onPressed: () =>
              context.push('/campeonatos/$idCampeonato/addPartido'),
          child: const Icon(Icons.add),
        ),
      ),
      showBackArrow: true,
      body: FutureBuilder(
        future: CampeonatoService().getPartidos(idCampeonato),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          final data = snapshot.data;
          final partidos = List<Map<String, dynamic>>.from(data as List)
              .map((p) => PartidoModel.fromApi(p));
          return SizedBox(
            width: size.width,
            child: Column(
              children: [
                Text('Calendario', style: textStyles.titleMedium),
                const SizedBox(height: 15),
                ...partidos.map(
                  (partido) => CardPartido(
                    p: partido,
                    size: size,
                    colors: colors,
                    textStyles: textStyles,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
