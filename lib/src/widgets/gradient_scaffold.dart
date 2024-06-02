import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final bool showBackArrow;
  final Widget? appbarWidget;
  final Widget? floatingActionButton;

  const GradientScaffold({
    super.key,
    required this.body,
    this.showBackArrow = false,
    this.appbarWidget,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appbarWidget == null ? Colors.transparent : null,
      extendBodyBehindAppBar: true, // Extender el body detrás del AppBar
      appBar: appbarWidget == null && !showBackArrow
          ? null
          : AppBar(
              title: appbarWidget,
              backgroundColor: appbarWidget == null
                  ? Colors.transparent
                  : colors.onError.withOpacity(0.5),
              elevation: 0,
            ),

      body: Container(
        padding: appbarWidget == null
            ? EdgeInsets.only(
                top: (MediaQuery.of(context).padding.top) + size.height * 0.1)
            : null,
        decoration: appbarWidget == null
            ? BoxDecoration(
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
              )
            : null,
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
