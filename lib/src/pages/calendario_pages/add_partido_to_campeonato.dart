import 'dart:async';

import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/services/services.dart';
import 'package:esports_app/src/widgets/shared/inputs/custom_text_input.dart';
import 'package:esports_app/src/widgets/shared/inputs/dropdown_input.dart';
import 'package:esports_app/src/widgets/shared/inputs/custom_date_input.dart';
import 'package:esports_app/src/widgets/shared/custom_filled_button.dart';
import 'package:esports_app/src/widgets/shared/inputs/custom_hours_input.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef FutureVoidCallbackWithInt = Future<void> Function(int);
typedef VoidFunctionTwoString = void Function(String, String);

class AddPartidoToCampeonato extends StatefulWidget {
  final int idCampeonato;
  final String? urlLogoCampeonato;
  const AddPartidoToCampeonato(
      {super.key, required this.idCampeonato, this.urlLogoCampeonato});

  @override
  State<AddPartidoToCampeonato> createState() => _AddPartidoToCampeonatoState();
}

class _AddPartidoToCampeonatoState extends State<AddPartidoToCampeonato> {
  final CampeonatoService _campeonatoService = CampeonatoService();
  bool loading = false;
  bool creating = false;
  late List<EquipoModel> equipos;
  late int equipoLocalId;
  late int equipoVisitanteId;
  //Reglas formulario
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerHour = TextEditingController();
  final TextEditingController _controllerLugar = TextEditingController();
  bool isEquiposIguales = false;
  bool isInvalidDate = true;
  bool isInvalidHour = true;
  bool isInvalidLugar = true;

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
        equipoLocalId = equipos[0].id;
        equipoVisitanteId = equipos[1].id;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEquipos(widget.idCampeonato);
  }

  void updateEquiposIds(int localId, int visitanteId) {
    setState(() {
      equipoLocalId = localId;
      equipoVisitanteId = visitanteId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return GradientScaffold(
      rightLogoUrl: widget.urlLogoCampeonato,
      showBackArrow: true,
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Agregar Partido', style: textStyles.titleMedium),
                  equipos.isEmpty
                      ? _NoHayEquipos(widget.idCampeonato, fetchEquipos)
                      : _HayEquipos(
                          updateEquiposIds: updateEquiposIds,
                          equipos: equipos,
                          validator: (String local, String visitante) {
                            setState(() {
                              isEquiposIguales = local == visitante;
                            });
                          }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomTextInput(
                      controller: _controllerLugar,
                      label: 'Lugar',
                      placeHolder: 'Estadio Monumental',
                      validator: () {
                        setState(() {
                          isInvalidLugar =
                              _controllerLugar.value.text.isEmpty ||
                                  _controllerLugar.value.text.length < 3;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomDateInput(
                      controller: _controllerDate,
                      label: 'Fecha',
                      validator: (String? errorsDate) {
                        setState(() {
                          isInvalidDate = errorsDate != null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomHourInput(
                      controller: _controllerHour,
                      label: 'Hora',
                      validator: (String? errorsHour) {
                        setState(() {
                          isInvalidHour = errorsHour != null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomFilledButton(
                    disabled: isEquiposIguales ||
                        isInvalidDate ||
                        isInvalidHour ||
                        isInvalidLugar ||
                        creating,
                    onPressed: () {
                      if (isEquiposIguales) return;
                      if (isInvalidDate) return;
                      if (isInvalidHour) return;
                      if (_controllerLugar.value.text.isEmpty &&
                          _controllerLugar.value.text.length < 3) return;
                      FocusScope.of(context)
                          .unfocus(); // Cierra el teclado si esta abierto
                      setState(() {
                        creating = true;
                      });

                      _campeonatoService.createPartido({
                        'campeonato_id': widget.idCampeonato,
                        'equipo_local_id': equipoLocalId,
                        'equipo_visitante_id': equipoVisitanteId,
                        'fecha': _controllerDate.value.text,
                        'hora': _controllerHour.value.text,
                        'lugar': _controllerLugar.value.text,
                        'estado': 0, // --> Pendiente
                      }).then((value) {
                        setState(() {
                          creating = false;
                        });
                        context.pop(true);
                      });
                    },
                    widgetText: creating
                        ? const CircularProgressIndicator()
                        : const Text('Añadir'),
                    fullWidth: true,
                  ),
                ],
              ),
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
                widgetText: const Text('Ir a Equipos'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _HayEquipos extends StatefulWidget {
  final List<EquipoModel> equipos;
  final VoidFunctionTwoString validator;
  final void Function(int localId, int visitanteId) updateEquiposIds;
  const _HayEquipos(
      {required this.equipos,
      required this.validator,
      required this.updateEquiposIds});

  @override
  State<_HayEquipos> createState() => _HayEquiposState();
}

class _HayEquiposState extends State<_HayEquipos> {
  late String local;
  late String visitante;
  void changeEquipoSelected(bool isLocal, String value) {
    setState(() {
      if (isLocal) {
        local = value;
        return;
      }
      visitante = value;
    });

    final EquipoModel equipoLocal =
        widget.equipos.firstWhere((equipo) => equipo.nombre == local);
    final EquipoModel equipoVisitante =
        widget.equipos.firstWhere((equipo) => equipo.nombre == visitante);

    widget.updateEquiposIds(equipoLocal.id, equipoVisitante.id);
    widget.validator(local, visitante);
  }

  @override
  void initState() {
    super.initState();
    local = widget.equipos[0].nombre;
    visitante = widget.equipos[1].nombre;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          DropdownInput<String>(
            initialValue: local,
            title: 'Equipo Local',
            list: widget.equipos.map((e) => e.nombre).toList(),
            iconos: widget.equipos
                .map(
                  (e) => SizedBox(
                    width: 20,
                    height: 20,
                    child: ImageWithLoader(imageUrl: e.imgUrl),
                  ),
                )
                .toList(),
            onChanged: (value) {
              changeEquipoSelected(true, value!);
            },
          ),
          const SizedBox(height: 30),
          DropdownInput<String>(
            initialValue: visitante,
            title: 'Equipo Visitante',
            list: widget.equipos.map((e) => e.nombre).toList(),
            iconos: widget.equipos
                .map(
                  (e) => SizedBox(
                    width: 20,
                    height: 20,
                    child: ImageWithLoader(imageUrl: e.imgUrl),
                  ),
                )
                .toList(),
            onChanged: (value) {
              changeEquipoSelected(false, value!);
            },
          ),
          local == visitante
              ? Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height * 0.05,
                    child: const Wrap(
                      children: [
                        Text(
                          'Los equipos no pueden ser iguales.',
                          style: TextStyle(color: Colors.red, fontSize: 15),
                          softWrap: true,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: size.height * 0.05,
                ),
        ],
      ),
    );
  }
}
