import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/services.dart';
import 'package:esports_app/src/widgets/dialogs/dialogs.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CampeonatoEquipos extends StatelessWidget {
  final int idCampeonato;
  const CampeonatoEquipos({super.key, required this.idCampeonato});

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
                context.push('/campeonatos/$idCampeonato/addEquipo'),
            child: const Icon(Icons.add),
          ),
        ),
        showBackArrow: true,
        body: FutureBuilder(
          future: CampeonatoService().getEquipos(idCampeonato),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            }

            final data = snapshot.data;
            final equipos = List<Map<String, dynamic>>.from(data as List)
                .map((c) => EquipoModel.fromApi(c))
                .toList();
            return Column(
              children: [
                SlideInRight(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: size.width,
                    height: size.height * 0.15,
                    child: Center(
                      child: Text(
                        'Equipos Clasificación',
                        style: textStyles.titleMedium,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    itemCount: equipos.length,
                    itemBuilder: (context, i) {
                      final equipo = equipos[i];

                      return FadeInUp(
                        child: InkWell(
                          onTap: () => infoEquipoDialog(context, equipo),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 10),
                            width: size.width,
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                                color: colors.background,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                ImageWithLoader(imageUrl: equipo.imgUrl),
                                const SizedBox(width: 10),
                                Text(equipo.nombre,
                                    style: textStyles.titleSmall),
                                const Spacer(),
                                Text(
                                  '${equipo.puntos}',
                                  style: textStyles.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}
