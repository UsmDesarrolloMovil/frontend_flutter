import 'package:esports_app/models/partido_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardPartido extends StatelessWidget {
  const CardPartido({
    super.key,
    required this.size,
    required this.colors,
    required this.textStyles,
    required this.p,
    required this.refreshState,
  });

  final VoidCallback refreshState;
  final PartidoModel p;
  final Size size;
  final ColorScheme colors;
  final TextTheme textStyles;
  Future<void> openDialogDeletePartido(BuildContext context, partidoId) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Estas seguro?'),
        content:
            const Text('Esta accion eliminará este Partido del calendario.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              await CampeonatoService().deletePartido(partidoId).then((value) {
                context.pop();
                refreshState();
              });
            },
            child: const Text('Aceptar'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 80,
      customBorder: const RoundedRectangleBorder(),
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.transparent,
      focusColor: colors.onError.withOpacity(.5),
      splashColor: colors.onError.withOpacity(.5),
      onLongPress: () => openDialogDeletePartido(context, p.id),
      child: Container(
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
      ),
    );
  }
}
