import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';

import 'package:animate_do/animate_do.dart';

void showOptionsCampeonatosDialog(BuildContext context, int idCampeonato) {
  Size size = MediaQuery.of(context).size;
  final textStyles = Theme.of(context).textTheme;
  final colors = Theme.of(context).colorScheme;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => ElasticInDown(
      child: AlertDialog(
        title: Column(
          children: [
            Text(
              'Gestionar Campeonato',
              style: textStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text('¿Que deseas hacer?',
                style: textStyles.titleSmall, textAlign: TextAlign.start)
          ],
        ),
        content: Container(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.8, // Máximo ancho
            maxHeight: size.height * 0.6, // Máximo alto
          ),
          width: double.infinity,
          // height: size.height * 0.3,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        10,
                      ))),
                  onPressed: () =>
                      context.push('/campeonatos/$idCampeonato/edit'),
                  child: const Row(
                    children: [
                      Icon(MdiIcons.pencilCircleOutline),
                      SizedBox(width: 10),
                      Text('Editar'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: colors.onError,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        10,
                      ))),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Icon(MdiIcons.deleteCircleOutline, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Eliminar', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cerrar menú'),
          ),
        ],
      ),
    ),
  );
}
