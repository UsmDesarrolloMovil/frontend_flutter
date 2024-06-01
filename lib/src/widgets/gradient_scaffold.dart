import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final String? appBarText;
  final Widget? floatingActionButton;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBarText,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    double top = MediaQuery.of(context).viewPadding.top;
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    Size size = MediaQuery.of(context).size;
    double perfectH = (size.height) - (top + bottom);

    return Scaffold(
      extendBodyBehindAppBar: true, // Extender el body detrás del AppBar
      appBar: appBarText == null
          ? null
          : AppBar(
              title: Row(
                children: [
                  const Icon(
                    MdiIcons.soccer,
                    color: Colors.white,
                  ),
                  Text(appBarText!),
                ],
              ),
              backgroundColor:
                  Colors.transparent, // Hacer transparente el color del AppBar
              elevation: 0,
            ),

      body: Container(
        padding: EdgeInsets.only(
            top: (MediaQuery.of(context).padding.top) + size.height * 0.1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.1, 0.15, 0.2, 0.25, 0.3, 1.0],
            colors: [
              colors.onError,
              colors.onError.withOpacity(0.8),
              colors.onError.withOpacity(0.5),
              colors.onError.withOpacity(0.3),
              colors.onError.withOpacity(0.2),
              Colors.transparent,
            ],
          ),
        ),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
