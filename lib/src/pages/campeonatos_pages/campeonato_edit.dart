import 'package:esports_app/models/campeonato_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CampeonatoEdit extends StatefulWidget {
  final int idCampeonato;
  const CampeonatoEdit({super.key, required this.idCampeonato});

  @override
  State<CampeonatoEdit> createState() => _CampeonatoEditState();
}

class _CampeonatoEditState extends State<CampeonatoEdit> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        showBackArrow: true,
        body: Center(
            child: SingleChildScrollView(
                child: Center(
          child: FutureBuilder(
              future: CampeonatoService().getById(widget.idCampeonato),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                final data = snapshot.data;
                final campeonato =
                    CampeonatoModel.fromApi(data as Map<String, dynamic>);
                TextEditingController _nombreCtrl = TextEditingController();
                _nombreCtrl.text = campeonato.nombre;
                TextEditingController _fechaInicioCtrl =
                    TextEditingController();
                _fechaInicioCtrl.text = campeonato.fechaInicio;
                TextEditingController _fechaFinCtrl = TextEditingController();
                _fechaFinCtrl.text = campeonato.fechaTermino;
                TextEditingController _premiosCtrl = TextEditingController();
                _premiosCtrl.text = campeonato.premios;
                TextEditingController _detallesCtrl = TextEditingController();
                _detallesCtrl.text = campeonato.detalles;
                TextEditingController _imagenUrlCtrl = TextEditingController();
                _imagenUrlCtrl.text = campeonato.imgUrl;
                TextEditingController _reglasCtrl = TextEditingController();
                _reglasCtrl.text = campeonato.reglas;
                final _formKey = GlobalKey<FormState>();

                return Form(
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
                        controller: _fechaInicioCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Fecha Inicio'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la fecha';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _fechaFinCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Fecha fin'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la fecha';
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
                      TextFormField(
                        controller: _premiosCtrl,
                        decoration: const InputDecoration(labelText: 'Premios'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese premio';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _detallesCtrl,
                        decoration:
                            const InputDecoration(labelText: 'Detalles'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese detalles';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: _reglasCtrl,
                        decoration: InputDecoration(
                          labelText: 'Reglas ',
                          contentPadding: EdgeInsets.all(8),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 255,
                        minLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese reglas';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            final updatedCampeonato = <String, dynamic>{
                              'nombre': _nombreCtrl.text,
                              'fecha_inicio': _fechaInicioCtrl.text,
                              'fecha_fin': _fechaFinCtrl.text,
                              'premios': _premiosCtrl.text,
                              'detalles': _detallesCtrl.text,
                              'imagen_url': _imagenUrlCtrl.text,
                              'reglas': _reglasCtrl.text
                            };
                            CampeonatoService()
                                .updateCampeonato(
                                    campeonato.id, updatedCampeonato)
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Campeonato actualizado')),
                              );
                              context.pop();
                              setState(() {
                                isLoading;
                              });
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: $error')),
                              );
                            });
                          }
                        },
                        child: !isLoading
                            ? const Text('Guardar')
                            : const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                );
              }),
        ))));
  }
}
