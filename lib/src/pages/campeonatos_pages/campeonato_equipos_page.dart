import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/services.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/image_with_loader.dart';
import 'package:flutter/material.dart';

class CampeonatoEquipos extends StatelessWidget {
  final int idCampeonato;
  const CampeonatoEquipos({super.key, required this.idCampeonato});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GradientScaffold(
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
                Container(
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
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    itemCount: equipos.length,
                    itemBuilder: (context, i) {
                      final equipo = equipos[i];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: size.width,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                            color: colors.background,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            ImageWithLoader(imageUrl: equipo.imgUrl),
                          ],
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
