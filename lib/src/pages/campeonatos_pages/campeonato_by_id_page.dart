import 'package:flutter/material.dart';

class CampeonatoById extends StatelessWidget {
  final int id;
  const CampeonatoById({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Campeonato by id: $id'),
      ),
    );
  }
}
