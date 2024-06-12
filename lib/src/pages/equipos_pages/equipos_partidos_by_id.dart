import 'package:esports_app/models/partido_model.dart';
import 'package:esports_app/src/services/equipos/equipos_service.dart';
import 'package:esports_app/src/widgets/partidos/card_partidos.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/shared/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class EquiposPartidosById extends StatefulWidget {
  final int idEquipo;
  const EquiposPartidosById({super.key, required this.idEquipo});

  @override
  State<EquiposPartidosById> createState() => _EquiposPartidosByIdState();
}

class _EquiposPartidosByIdState extends State<EquiposPartidosById> {
  bool loading = true;
  late String equipoNombre;
  late String equipoImagen;
  late List<PartidoModel> partidos;

  void fetchPartidos() async {
    await EquipoService().getPartidos(widget.idEquipo).then((data) {
      setState(() {
        loading = false;
        equipoNombre = data['nombre'];
        equipoImagen = data['imagen_url'];
        partidos = List<Map<String, dynamic>>.from(data['partidos'] as List)
            .map((p) => PartidoModel.fromApi(p))
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPartidos();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GradientScaffold(
      showBackArrow: true,
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SizedBox(
              width: size.width,
              child: ListView(
                padding: const EdgeInsets.only(top: 0),
                children: [
                  Center(
                      child: Text(equipoNombre, style: textStyles.titleMedium)),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: size.height * 0.2,
                      height: size.height * 0.2,
                      child: ImageWithLoader(imageUrl: equipoImagen),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(MdiIcons.gamepadCircle),
                        const SizedBox(width: 10),
                        Text(
                          'Partidos asociados',
                          style: textStyles.titleSmall,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  ...partidos.map((partido) => CardPartido(
                        p: partido,
                        refreshState: () {},
                      ))
                ],
              ),
            ),
    );
  }
}
