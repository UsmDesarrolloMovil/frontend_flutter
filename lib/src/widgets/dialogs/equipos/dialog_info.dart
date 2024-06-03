import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/equipo_model.dart';

void infoEquipoDialog(BuildContext context, EquipoModel equipo) {
  Size size = MediaQuery.of(context).size;
  final textStyles = Theme.of(context).textTheme;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => ElasticInDown(
      child: AlertDialog(
        title: Column(
          children: [
            Text(equipo.nombre,
                style: textStyles.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: 15),
            SizedBox(
              width: size.width * 0.2,
              height: size.width * 0.2,
              child: ImageWithLoader(imageUrl: equipo.imgUrl),
            ),
            const SizedBox(height: 15),
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
                Text('Participa en:',
                    style: textStyles.titleSmall, textAlign: TextAlign.center),
                const SizedBox(height: 15),
                ...equipo.listarJuegos.map((juego) {
                  return Text('- $juego');
                }),
                const SizedBox(height: 15),
                Text('Integrantes:',
                    style: textStyles.titleSmall, textAlign: TextAlign.center),
                const SizedBox(height: 15),
                ...equipo.jugadores.map((juego) {
                  return Text('- $juego');
                }),
              ],
            ),
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => context.push('/equipos/${equipo.id}/partidos'),
            child: const Text('Ver Partidos'),
          ),
          FilledButton(
            onPressed: () => context.push('/equipos/${equipo.id}'),
            child: const Text('Editar'),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    ),
  );
}
