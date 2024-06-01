import 'package:flutter/material.dart';

class EquipoById extends StatelessWidget {
  final int id;
  const EquipoById({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Equipo by id: $id'),
      ),
    );
  }
}
