import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/equipos/equipos_service.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class EquipoById extends StatelessWidget {
  final int id;
  const EquipoById({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        appbarWidget: const Row(
          children: [
            Text('Equipos'),
          ],
        ),
        body: FutureBuilder(
            future: EquipoService().getById(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              final data = snapshot.data;
              final equipo = EquipoModel.fromApi(data as Map<String, dynamic>);
              TextEditingController _nombreCtrl = TextEditingController();
              _nombreCtrl.text = equipo.nombre;
              TextEditingController _juegosCtrl = TextEditingController();
              _juegosCtrl.text = equipo.juegos;

              TextEditingController _imagenUrlCtrl = TextEditingController();
              _imagenUrlCtrl.text = equipo.imgUrl;
              final _formKey = GlobalKey<FormState>();
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nombreCtrl,
                        decoration: const InputDecoration(labelText: 'Nombre'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el nombre';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _juegosCtrl,
                        decoration: const InputDecoration(labelText: 'Juegos'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese los juegos';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _imagenUrlCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Imagen URL'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la URL de la imagen';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final updatedEquipo = <String, dynamic>{
                              'nombre': _nombreCtrl.text,
                              'juegos': _juegosCtrl.text,
                              'imagen_url': _imagenUrlCtrl.text,
                            };
                            EquipoService()
                                .updateEquipo(equipo.id,
                                    updatedEquipo as Map<String, dynamic>)
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Equipo actualizado')),
                              );
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $error')),
                              );
                            });
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
