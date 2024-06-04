import 'dart:async';

import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/shared/custom_filled_button.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef FutureVoidCallbackWithInt = Future<void> Function(int);

class AddPartidoToCampeonato extends StatefulWidget {
  final int idCampeonato;
  const AddPartidoToCampeonato({super.key, required this.idCampeonato});

  @override
  State<AddPartidoToCampeonato> createState() => _AddPartidoToCampeonatoState();
}

class _AddPartidoToCampeonatoState extends State<AddPartidoToCampeonato> {
  bool loading = false;
  late List<EquipoModel> equipos;

  Future<void> fetchEquipos(int idCampeonato) async {
    setState(() {
      loading = true;
    });
    await CampeonatoService().getEquipos(idCampeonato).then((data) {
      final equiposFetched = List<Map<String, dynamic>>.from(data)
          .map((e) => EquipoModel.fromApi(e))
          .toList();
      setState(() {
        equipos = equiposFetched;
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEquipos(widget.idCampeonato);
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return GradientScaffold(
      showBackArrow: true,
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Column(
              children: [
                Text('Agregar Partido', style: textStyles.titleMedium),
                equipos.isEmpty
                    ? _NoHayEquipos(widget.idCampeonato, fetchEquipos)
                    : Center(
                        child: Text('Hay ${equipos.length} equipos.'),
                      )
              ],
            ),
    );
  }
}

class _NoHayEquipos extends StatelessWidget {
  final int idCampeonato;
  final FutureVoidCallbackWithInt fetchEquipos;
  const _NoHayEquipos(this.idCampeonato, this.fetchEquipos);

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Text('Información', style: textStyles.titleSmall),
          const Text(
            'Este Campeonato no cuenta con equipos asignados, por ende NO puedes crear partidos aquí aún.',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFilledButton(
                animated: false,
                onPressed: () => context
                    .push('/campeonatos/$idCampeonato/equipos')
                    .then((value) => fetchEquipos(idCampeonato)),
                text: 'Ir a Equipos',
              ),
            ],
          )
        ],
      ),
    );
  }
}
