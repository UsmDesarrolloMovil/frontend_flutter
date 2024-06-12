import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/equipos/equipos_service.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddEquipoToCampeonato extends StatefulWidget {
  final int idCampeonato;
  final String? urlLogoCampeonato;
  const AddEquipoToCampeonato(
      {super.key, required this.idCampeonato, this.urlLogoCampeonato});

  @override
  State<AddEquipoToCampeonato> createState() => _AddEquipoToCampeonatoState();
}

class _AddEquipoToCampeonatoState extends State<AddEquipoToCampeonato> {
  List<int> equiposId = [];
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        rightLogoUrl: widget.urlLogoCampeonato,
        showBackArrow: true,
        body: Center(
            child: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: EquipoService()
                    .getEquiposNoEnCampeonato(widget.idCampeonato),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  final data = snapshot.data!;
                  final equipos = List<Map<String, dynamic>>.from(data as List)
                      .map((e) => EquipoModel.fromApi(e))
                      .toList();
                  return ListView.builder(
                    itemCount: equipos.length,
                    itemBuilder: (context, index) {
                      final equipo = equipos[index];
                      return CheckboxListTile(
                        title: Row(
                          children: [
                            SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.network(equipo.imgUrl)),
                            SizedBox(
                              height: 45,
                              width: 45,
                            ),
                            Text(equipo.nombre),
                          ],
                        ),
                        value: equiposId.contains(equipo.id),
                        onChanged: (bool? newValue) {
                          setState(() {
                            if (newValue == true) {
                              equiposId.add(equipo.id);
                              print(equiposId);

                              return;
                            }
                            equiposId.remove(equipo.id);
                            print(equiposId);
                          });
                        },
                      );
                    },
                  );
                }),
          ),
          Container(
              height: 75,
              width: double.infinity,
              child: ElevatedButton(
                  child: Text('Agregar equipos'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(
                                "Agregar estos equipos a este campeonato?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                              TextButton(
                                  child: Text("Agregar equipo(s)"),
                                  onPressed: () {
                                    for (var i = 0; i < equiposId.length; i++) {
                                      final newEquipoCampeonato =
                                          <String, dynamic>{
                                        'campeonato_id': widget.idCampeonato,
                                        'equipo_id': equiposId[i],
                                        'puntos': 0,
                                      };
                                      EquipoService().createEquipoCampeonato(
                                          newEquipoCampeonato);
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Campeonato actualizado')),
                                    );
                                    context.pop();
                                    context.pop();
                                    setState(() {});
                                  })
                            ]);
                      },
                    );
                  }))
        ])));
  }
}
