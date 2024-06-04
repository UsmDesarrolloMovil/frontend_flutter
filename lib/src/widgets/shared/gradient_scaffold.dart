import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final bool showBackArrow;
  final Widget? appbarWidget;
  final Widget? floatingActionButton;
  final bool addPadding;

  const GradientScaffold({
    super.key,
    required this.body,
    this.showBackArrow = false,
    this.addPadding = true,
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

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              decoration: appbarWidget == null
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [
                          // 0.05,
                          0.1,
                          // 0.2,
                          // 0.3,
                          // 0.4,
                          // 0.5,
                          // 0.6,
                          // 0.7,
                          // 0.8,
                          // 0.9,
                          1.0
                        ],
                        colors: [
                          colors.onError,
                          // colors.onError.withOpacity(0.9),
                          // colors.onError.withOpacity(0.8),
                          // colors.onError.withOpacity(0.7),
                          // colors.onError.withOpacity(0.6),
                          // colors.onError.withOpacity(0.5),
                          // colors.onError.withOpacity(0.4),
                          // colors.onError.withOpacity(0.3),
                          // colors.onError.withOpacity(0.2),
                          // colors.onError.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    )
                  : null,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                padding: addPadding
                    ? EdgeInsets.only(
                        top: (MediaQuery.of(context).padding.top) +
                            size.height * 0.12)
                    : null,
                // width: ,
                child: body,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
