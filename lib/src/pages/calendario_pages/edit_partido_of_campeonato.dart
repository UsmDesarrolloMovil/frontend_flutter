import 'dart:async';

import 'package:esports_app/models/partido_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/partidos/card_partidos.dart';
import 'package:esports_app/src/widgets/shared/custom_filled_button.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:esports_app/src/widgets/shared/inputs/custom_text_input.dart';
import 'package:esports_app/src/widgets/shared/inputs/dropdown_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';

class EditPartidoOfCampeonato extends StatefulWidget {
  final int idPartido;
  const EditPartidoOfCampeonato({super.key, required this.idPartido});

  @override
  State<EditPartidoOfCampeonato> createState() =>
      _EditPartidoOfCampeonatoState();
}

class _EditPartidoOfCampeonatoState extends State<EditPartidoOfCampeonato> {
  bool loading = false;
  bool editing = false;
  bool tappedSubmit = false;
  late PartidoModel partido;
  int? equipoGanadorId;

  //Formulario propertys
  late TextEditingController _controllerLocal;
  late TextEditingController _controllerVisitante;
  late int estado;

  Future<void> fetchPartido(int idPartido) async {
    setState(() {
      loading = true;
    });
    await CampeonatoService().getPartido(idPartido).then((dataFromApi) {
      Map<String, dynamic> data = dataFromApi.cast<String, dynamic>();
      final partidoFetched = PartidoModel.fromApiEdit(data);
      setState(() {
        partido = partidoFetched;
        estado = partidoFetched.estado;
        loading = false;
        equipoGanadorId = partidoFetched.equipoGanador;
        _controllerLocal = TextEditingController(
            text: (partidoFetched.puntosLocal?.toString() ?? ''));
        _controllerVisitante = TextEditingController(
            text: (partidoFetched.puntosVisitante?.toString() ?? ''));
      });
    });
  }

  @override
  void initState() {
    fetchPartido(widget.idPartido);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    return GradientScaffold(
      showBackArrow: true,
      body: Center(
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : ListView(
                padding: const EdgeInsets.only(top: 5, left: 18, right: 18),
                children: [
                  Center(
                    child:
                        Text('Editar Partido', style: textStyles.titleMedium),
                  ),
                  const SizedBox(height: 20),
                  CardPartido(p: partido, refreshState: () {}),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Equipo ganador',
                      style: textStyles.titleSmall,
                    ),
                  ),
                  CheckboxListTile(
                    enabled: estado == 1,
                    activeColor: colors.onError,
                    checkColor: Colors.white,
                    title: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: ImageWithLoader(imageUrl: partido.imagenLocal),
                        ),
                        const SizedBox(width: 10),
                        Text('${partido.equipoLocal}(Local)'),
                      ],
                    ),
                    value: partido.equipoLocalId == equipoGanadorId,
                    onChanged: (bool? newValue) {
                      setState(() {
                        equipoGanadorId = partido.equipoLocalId;
                      });
                    },
                  ),
                  CheckboxListTile(
                    enabled: estado == 1,
                    activeColor: colors.onError,
                    checkColor: Colors.white,
                    title: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: ImageWithLoader(
                              imageUrl: partido.imagenVisitante),
                        ),
                        const SizedBox(width: 10),
                        Text('${partido.equipoVisitante}(Visitante)'),
                      ],
                    ),
                    value: partido.equipoVisitanteId == equipoGanadorId,
                    onChanged: (bool? newValue) {
                      setState(() {
                        equipoGanadorId = partido.equipoVisitanteId;
                      });
                    },
                  ),
                  DropdownInput<String>(
                    list: const ['Pendiente', 'En Curso', 'Finalizado'],
                    title: 'Estado',
                    iconos: const [
                      Icon(MdiIcons.clockOutline),
                      Icon(Icons.wifi_protected_setup_outlined),
                      Icon(MdiIcons.checkCircleOutline),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          estado = PartidoModel.estadoToInt(value);
                        });
                      }
                    },
                    initialValue: PartidoModel.estadoToString(estado),
                  ),
                  const SizedBox(height: 5),
                  estado == 1
                      ? Container()
                      : const Text(
                          'Para modificar los demas campos, el estado debe estar en "Finalizado".',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                  const SizedBox(height: 20),
                  CustomTextInput(
                    disabled: estado != 1,
                    maxLength: 2,
                    inputType: TextInputType.number,
                    controller: _controllerLocal,
                    label: 'Marcador Local (${partido.equipoLocal})',
                    placeHolder: 'Marcador del equipo local',
                    validator: () {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextInput(
                    disabled: estado != 1,
                    maxLength: 2,
                    inputType: TextInputType.number,
                    controller: _controllerVisitante,
                    label: 'Marcador Visitante (${partido.equipoVisitante})',
                    placeHolder: 'Marcador del equipo Visitante',
                    validator: () {
                      setState(() {});
                    },
                  ),
                  // const SizedBox(height: 15),
                  Visibility(
                    visible:
                        equipoGanadorId == null && estado == 1 && tappedSubmit,
                    child: Text(
                      '*Se debe definir un equipo ganador.',
                      style: TextStyle(
                        color: colors.errorContainer,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _controllerLocal.value.text.isEmpty &&
                        estado == 1 &&
                        tappedSubmit,
                    child: Text(
                      '*Se debe definir el marcador del equipo local.',
                      style: TextStyle(
                        color: colors.errorContainer,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _controllerVisitante.value.text.isEmpty &&
                        estado == 1 &&
                        tappedSubmit,
                    child: Text(
                      '*Se debe definir el marcador del equipo visitante.',
                      style: TextStyle(
                        color: colors.errorContainer,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomFilledButton(
                    disabled: estado == partido.estado || editing,
                    onPressed: () async {
                      //Validaciones
                      if (estado == partido.estado) return;
                      setState(() {
                        tappedSubmit = true;
                      });
                      if (estado == 1 && equipoGanadorId == null) return;
                      if (estado == 1 && _controllerLocal.value.text.isEmpty)
                        return;
                      if (estado == 1 &&
                          _controllerVisitante.value.text.isEmpty) return;

                      //Comenzar modificacion de partido
                      final Map<String, dynamic> partidoData = {
                        'partido_id': partido.id,
                        'estado': estado,
                        if (estado != 2 && estado != 0) ...{
                          'equipo_ganador_id': equipoGanadorId,
                          'puntos_local': _controllerLocal.value.text,
                          'puntos_visitante': _controllerVisitante.value.text,
                        },
                      };
                      setState(() {
                        editing = true;
                      });
                      await CampeonatoService()
                          .editPartido(partidoData)
                          .then((value) {
                        setState(() {
                          editing = false;
                        });
                        context.pop(true);
                      });
                    },
                    widgetText: editing
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : const Text('Actualizar'),
                    fullWidth: true,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
      ),
    );
  }
}
