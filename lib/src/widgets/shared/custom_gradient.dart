import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final List<double> stops;
  final List<Color> colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  const CustomGradient({
    super.key,
    required this.stops,
    required this.colors,
    required this.begin,
    this.end = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
