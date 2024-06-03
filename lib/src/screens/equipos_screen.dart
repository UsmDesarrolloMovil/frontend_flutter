import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/equipos/equipos_service.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';

class EquiposScreen extends StatelessWidget {
  const EquiposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        addPadding: false,
        appbarWidget: const Row(
          children: [
            Icon(
              MdiIcons.accountGroup,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text('Equipos'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddEquipoDialog(context);
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
            future: EquipoService().getAll(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              final data = snapshot.data;
              final equipos = List<Map<String, dynamic>>.from(data as List)
                  .map((c) => EquipoModel.fromApi(c))
                  .toList();
              return ListView.builder(
                  itemCount: equipos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        equipos[index].imgUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image, size: 50);
                        },
                      ),
                      title: Text(equipos[index].nombre),
                      subtitle: Text(equipos[index].juegos),
                      onTap: () {
                        context.push('/equipos/${equipos[index].id}');

                        // Acción al hacer clic en el ListTile
                      },
                    );
                  });
            }));
  }

  void _showAddEquipoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        TextEditingController _nombreCtrl = TextEditingController();
        TextEditingController _juegosCtrl = TextEditingController();
        TextEditingController _imagenUrlCtrl = TextEditingController();

        return AlertDialog(
          title: Text('Añadir Equipo'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _nombreCtrl,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Juegos'),
                  controller: _juegosCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los juegos';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imagenUrlCtrl,
                  decoration: InputDecoration(labelText: 'URL de la Imagen'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la URL de la imagen';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: Text('Guardar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newEquipo = <String, dynamic>{
                      'nombre': _nombreCtrl.text,
                      'juegos': _juegosCtrl.text,
                      'imagen_url': _imagenUrlCtrl.text,
                    };
                    EquipoService()
                        .createEquipo(newEquipo as Map<String, dynamic>)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Equipo creado')),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $error')),
                      );
                    });
                    Navigator.of(context).pop();
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
