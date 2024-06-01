import 'dart:math';

import 'package:esports_app/src/widgets/custom_filled_button.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GradientScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _Header(),
            SizedBox(height: 30),
            _Content(),
            Spacer(),
            CustomFilledButton(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Column(
      children: [
        Text('Bienvenido a', style: textStyles.titleSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              MdiIcons.trophy,
              size: 35,
              color: Colors.yellow[800],
            ),
            const SizedBox(width: 5),
            Text(
              'Sports',
              style: textStyles.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          'Mantente actualizado con puntajes, estadísticas, horarios y jugada por jugada en tiempo real de todas sus ligas y equipos favoritos. \n\n 👇🏻',
          style: textStyles.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Expanded(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: size.width * 0.4,
            height: size.width * 0.5,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('Campeonatos'),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            width: size.width * 0.4,
            height: size.width * 0.5,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text('Equipos'),
            ),
          ),
        ],
      ),
    );
  }
}
