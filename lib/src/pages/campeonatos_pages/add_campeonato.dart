import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AddCampeonato extends StatefulWidget {
  const AddCampeonato({super.key});

  @override
  State<AddCampeonato> createState() => _AddCampeonatoState();
}

class _AddCampeonatoState extends State<AddCampeonato> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey();
    TextEditingController _nombreCtrl = TextEditingController();
    TextEditingController _fechaInicioCtrl = TextEditingController();
    _fechaInicioCtrl.text = '2025-06-01';

    TextEditingController _fechaFinCtrl = TextEditingController();
    _fechaFinCtrl.text = '2026-06-01';
    TextEditingController _premiosCtrl = TextEditingController();
    TextEditingController _detallesCtrl = TextEditingController();
    TextEditingController _imagenUrlCtrl = TextEditingController();
    TextEditingController _reglasCtrl = TextEditingController();

    return GradientScaffold(
      showBackArrow: true,
      body: SingleChildScrollView(
        child: Center(
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
                controller: _fechaInicioCtrl,
                decoration: const InputDecoration(labelText: 'Fecha Inicio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fechaFinCtrl,
                decoration: const InputDecoration(labelText: 'Fecha fin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha';
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
                decoration: const InputDecoration(labelText: 'Detalles'),
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
                    final campeonato = <String, dynamic>{
                      'nombre': _nombreCtrl.text,
                      'fecha_inicio': _fechaInicioCtrl.text,
                      'fecha_fin': _fechaFinCtrl.text,
                      'premios': _premiosCtrl.text,
                      'detalles': _detallesCtrl.text,
                      'imagen_url': _imagenUrlCtrl.text,
                      'reglas': _reglasCtrl.text
                    };
                    CampeonatoService().createCampeonato(campeonato).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Campeonato creado')),
                      );
                      context.pop();
                      setState(() {});
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
        )),
      ),
    );
  }
}
