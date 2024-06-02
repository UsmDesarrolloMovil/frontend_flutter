import 'package:esports_app/src/widgets/custom_filled_button.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedContainer;

  void changeSelection(int containerReference) {
    setState(() {
      selectedContainer = containerReference;
    });
  }

  int? getSelection() {
    return selectedContainer;
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _Header(),
          _Content(getSelection, changeSelection),
          const Spacer(),
          Visibility(
            visible: selectedContainer != null,
            child: CustomFilledButton(
              text: 'Continuar',
              animated: true,
              fullWidth: true,
              onPressed: () {
                switch (getSelection()) {
                  case 0:
                    context.push('/campeonatos');
                  case 1:
                    context.push('/equipos');
                  default:
                }
              },
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
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
          const SizedBox(height: 30),
          Text(
            'Seleccione:',
            style: textStyles.titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final int? Function() getSelection;
  final void Function(int) setSelection;
  const _Content(this.getSelection, this.setSelection);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final selection = getSelection();
    final colors = Theme.of(context).colorScheme;
    final List<BoxShadow> boxshadow = [
      BoxShadow(
        color: colors.onError,
        offset: const Offset(0, 0),
        blurRadius: 16,
        spreadRadius: 4,
      )
    ];
    return SizedBox(
      width: size.width,
      height: size.height * 0.3,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        scrollDirection: Axis.horizontal,
        children: [
          InkResponse(
            radius: 50,
            splashColor: colors.onError,
            onTap: () => setSelection(0),
            child: Container(
              width: size.width * 0.45,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(10),
                boxShadow: selection != null && selection == 0 ? boxshadow : [],
              ),
              child: const Center(
                child: Text('Campeonatos'),
              ),
            ),
          ),
          const SizedBox(width: 20),
          InkResponse(
            radius: 50,
            splashColor: colors.onError,
            onTap: () => setSelection(1),
            child: Container(
              width: size.width * 0.45,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(10),
                boxShadow: selection != null && selection == 1 ? boxshadow : [],
              ),
              child: const Center(
                child: Text('Equipos'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
