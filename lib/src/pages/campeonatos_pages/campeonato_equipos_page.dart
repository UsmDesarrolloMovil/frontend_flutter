import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/services.dart';
import 'package:esports_app/src/widgets/dialogs/dialogs.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CampeonatoEquipos extends StatefulWidget {
  final int idCampeonato;
  const CampeonatoEquipos({super.key, required this.idCampeonato});

  @override
  State<CampeonatoEquipos> createState() => _CampeonatoEquiposState();
}

class _CampeonatoEquiposState extends State<CampeonatoEquipos> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    openDialogDeleteEquipo(BuildContext context, equipoId) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('¿Estas seguro?'),
          content:
              const Text('Esta accion eliminará este Equipo del Campeonato.'),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                EquipoService()
                    .deleteEquipoCampeonato(equipoId, widget.idCampeonato)
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Campeonato Borrado')),
                  );
                  context.pop();
                  setState(() {});
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                });
              },
              child: const Text('Aceptar'),
            )
          ],
        ),
      );
    }

    return GradientScaffold(
        floatingActionButton: SlideInRight(
          delay: const Duration(seconds: 1),
          child: FloatingActionButton(
            onPressed: () => context
                .push('/campeonatos/${widget.idCampeonato}/addEquipo')
                .then((value) {
              setState(() {});
            }),
            child: const Icon(Icons.add),
          ),
        ),
        showBackArrow: true,
        body: FutureBuilder(
          future: CampeonatoService().getEquipos(widget.idCampeonato),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Visibility(
                    visible: equipos.isEmpty,
                    child: Text(
                      '😢 No hay equipos asignados',
                      style: textStyles.titleSmall,
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
                          radius: 80,
                          customBorder: const RoundedRectangleBorder(),
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Colors.transparent,
                          focusColor: colors.onError.withOpacity(.5),
                          splashColor: colors.onError.withOpacity(.5),
                          onLongPress: () {
                            openDialogDeleteEquipo(context, equipo.id);
                          },
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
