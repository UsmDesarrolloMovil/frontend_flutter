import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/equipos/equipos_service.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class EquipoById extends StatefulWidget {
  final int id;
  const EquipoById({super.key, required this.id});

  @override
  State<EquipoById> createState() => _EquipoByIdState();
}

class _EquipoByIdState extends State<EquipoById> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        appbarWidget: const Row(
          children: [
            Text('Equipo'),
          ],
        ),
        body: FutureBuilder(
            future: EquipoService().getById(widget.id),
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
                  child: Column(
                    children: [
                      EquipoForm(
                          formKey: _formKey,
                          nombreCtrl: _nombreCtrl,
                          juegosCtrl: _juegosCtrl,
                          imagenUrlCtrl: _imagenUrlCtrl,
                          equipo: equipo),
                      ListTile(
                        title: Text('Nombre Jugador'),
                        trailing: Text('Id Jugador'),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: FutureBuilder(
                            future:
                                EquipoService().getJugadoresEquipo(widget.id),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                );
                              }
                              final data = snapshot.data;
                              final jugadores = data;
                              if (jugadores!.isEmpty) {
                                return Center(
                                  child: ListView(
                                    children: [
                                      Spacer(),
                                      Center(
                                        child: Text(
                                          'No hay jugadores en este equipo!',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                      ),
                                      Spacer(),
                                      Center(
                                          child: Text('Haz click en el boton')),
                                      Center(child: Text('de abajo para')),
                                      Center(
                                          child: Text('ingresar un jugador.')),
                                      Spacer(),
                                    ],
                                  ),
                                );
                              }
                              return ListView.builder(
                                  padding: EdgeInsets.only(top: 0),
                                  itemCount: jugadores!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          title:
                                              Text(jugadores[index]['nombre']),
                                          trailing: Text(jugadores[index]['id']
                                              .toString()),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                TextEditingController
                                                    _nombreJugadorCtrl =
                                                    TextEditingController();
                                                _nombreJugadorCtrl.text =
                                                    jugadores[index]['nombre'];

                                                return AlertDialog(
                                                  title: Text(
                                                      "Editar ${jugadores[index]['nombre']} ?"),
                                                  content: TextFormField(
                                                    controller:
                                                        _nombreJugadorCtrl,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Nombre'),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Por favor ingrese el nombre';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("Cancel"),
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("Editar"),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          final jugadorEdited =
                                                              <String, dynamic>{
                                                            'nombre':
                                                                _nombreJugadorCtrl
                                                                    .text,
                                                            'equipo_id':
                                                                widget.id,
                                                          };
                                                          EquipoService()
                                                              .updateJugador(
                                                                  jugadores[
                                                                          index]
                                                                      ['id'],
                                                                  jugadorEdited)
                                                              .then((_) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      'Jugador Editado')),
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pop();

                                                            setState(() {});
                                                          }).catchError(
                                                                  (error) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      'Error: $error')),
                                                            );
                                                          });
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'No es valido el form')),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          onLongPress: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Borrar ${jugadores[index]['nombre']} ?"),
                                                  content: Text(
                                                      "Seguro desea borrar este Jugador?"),
                                                  actions: [
                                                    TextButton(
                                                      child: Text("Cancel"),
                                                      onPressed: () {
                                                        context.pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("BORRAR"),
                                                      onPressed: () {
                                                        EquipoService()
                                                            .deleteJugador(
                                                                jugadores[index]
                                                                    ['id'])
                                                            .then((_) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Jugador borrado')),
                                                          );
                                                          context.pop();
                                                          setState(() {});
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        Divider()
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: ElevatedButton(
                            onPressed: () {
                              _showAddEquipoDialog(context);
                            },
                            child: const Text('Agregar jugador')),
                      )
                    ],
                  ));
            }));
  }

  void _showAddEquipoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        TextEditingController _nombreCtrl = TextEditingController();
        return AlertDialog(
          title: const Text('Añadir Jugador'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('Guardar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newJugador = <String, dynamic>{
                      'nombre': _nombreCtrl.text,
                      'equipo_id': widget.id,
                    };
                    EquipoService()
                        .createJugadores(newJugador as Map<String, dynamic>)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Jugador creado')),
                      );
                      Navigator.of(context).pop();

                      setState(() {});
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No es valido el form')),
                    );
                  }
                }),
          ],
        );
      },
    );
  }
}

class EquipoForm extends StatelessWidget {
  const EquipoForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nombreCtrl,
    required TextEditingController juegosCtrl,
    required TextEditingController imagenUrlCtrl,
    required this.equipo,
  })  : _formKey = formKey,
        _nombreCtrl = nombreCtrl,
        _juegosCtrl = juegosCtrl,
        _imagenUrlCtrl = imagenUrlCtrl;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nombreCtrl;
  final TextEditingController _juegosCtrl;
  final TextEditingController _imagenUrlCtrl;
  final EquipoModel equipo;

  @override
  Widget build(BuildContext context) {
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
            decoration: const InputDecoration(labelText: 'Imagen URL'),
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
                    .updateEquipo(
                        equipo.id, updatedEquipo as Map<String, dynamic>)
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Equipo actualizado')),
                  );
                  context.pop();
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
    );
  }
}
