import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/partido_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/image_with_loader.dart';
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
                  (partido) => _CardPartido(
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

class _CardPartido extends StatelessWidget {
  const _CardPartido({
    required this.size,
    required this.colors,
    required this.textStyles,
    required this.p,
  });

  final PartidoModel p;
  final Size size;
  final ColorScheme colors;
  final TextTheme textStyles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.15,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ImageWithLoader(imageUrl: p.imagenLocal),
              ),
              // const SizedBox(height: 10),
              ...p.equipoLocal.split(' ').map((n) => Text(n,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                  )))
            ],
          ),
          const SizedBox(width: 15),
          Text('${p.puntosLocal ?? '-'}', style: textStyles.titleMedium),
          const Spacer(),
          Column(
            mainAxisAlignment: p.isFinished
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: [
              Text(
                p.lugar,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              p.isFinished
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Finalizado',
                        style: textStyles.titleSmall,
                      ),
                    )
                  : const SizedBox(),
              !p.isFinished
                  ? Text(
                      p.hora,
                      style: textStyles.titleSmall,
                    )
                  : const SizedBox(),
              !p.isFinished
                  ? Text(
                      p.fecha.split(' ')[0],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const Spacer(),
          Text('${p.puntosVisitante ?? '-'}', style: textStyles.titleMedium),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ImageWithLoader(imageUrl: p.imagenVisitante),
              ),
              ...p.equipoVisitante.split(' ').map((n) => Text(n,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                  )))
            ],
          ),
        ],
      ),
    );
  }
}
