import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/campeonato_model.dart';
import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/custom_filled_button.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';

class CampeonatoById extends StatefulWidget {
  final int id;
  const CampeonatoById({super.key, required this.id});

  @override
  State<CampeonatoById> createState() => _CampeonatoByIdState();
}

class _CampeonatoByIdState extends State<CampeonatoById> {
  bool showParticipantes = false;

  void enableParticipantes() {
    setState(() {
      showParticipantes = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return GradientScaffold(
        showBackArrow: true,
        body: FutureBuilder(
          future: CampeonatoService().getById(widget.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            }
            final data = snapshot.data;
            final campeonato =
                CampeonatoModel.fromApi(data as Map<String, dynamic>);
            return SizedBox(
              width: size.width,
              child: Column(
                children: [
                  SlideInLeft(
                    child: Text(
                      campeonato.nombre,
                      style: textStyles.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: size.height * 0.07),
                  _HeaderInfo(
                    textStyles: textStyles,
                    campeonato: campeonato,
                    colors: colors,
                  ),
                  SizedBox(height: size.height * 0.07),
                  CustomFilledButton(
                    text: 'Ver Participantes',
                    onPressed: () =>
                        context.push('/campeonatos/${campeonato.id}/equipos'),
                  )
                ],
              ),
            );
          },
        ));
  }
}

class _HeaderInfo extends StatelessWidget {
  const _HeaderInfo({
    required this.textStyles,
    required this.campeonato,
    required this.colors,
  });

  final TextTheme textStyles;
  final CampeonatoModel campeonato;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FadeInUp(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Inicio', style: textStyles.titleSmall),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(campeonato.fechaInicio,
                      style: textStyles.titleSmall),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text('Finalización', style: textStyles.titleSmall),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: colors.errorContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(campeonato.fechaTermino,
                      style: textStyles.titleSmall),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(MdiIcons.bookOutline),
                Text(
                  'Detalles',
                  style: textStyles.titleMedium,
                ),
              ],
            ),
            Text(
              campeonato.detalles,
              style: textStyles.titleSmall,
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const Icon(MdiIcons.cashMultiple),
                Text(
                  'Premios',
                  style: textStyles.titleMedium,
                ),
              ],
            ),
            Text(
              campeonato.premios,
              style: textStyles.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
