import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/partido_model.dart';
import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:esports_app/src/widgets/partidos/card_partidos.dart';
import 'package:esports_app/src/widgets/shared/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CalendarioCampeonato extends StatefulWidget {
  final int idCampeonato;
  const CalendarioCampeonato({
    super.key,
    required this.idCampeonato,
  });

  @override
  State<CalendarioCampeonato> createState() => _CalendarioCampeonatoState();
}

class _CalendarioCampeonatoState extends State<CalendarioCampeonato> {
  bool loading = false;
  bool loadingWithPartidos = false;
  late List<PartidoModel> partidos;

  Future<void> fetchPartidos(int idCampeonato, bool existPartidos) async {
    setState(() {
      if (existPartidos) {
        loadingWithPartidos = true;
        return;
      }
      loading = true;
    });
    await CampeonatoService().getPartidos(idCampeonato).then((data) {
      final partidosFetched = List<Map<String, dynamic>>.from(data)
          .map((p) => PartidoModel.fromApi(p))
          .toList();
      setState(() {
        partidos = partidosFetched;
        if (existPartidos) {
          loadingWithPartidos = false;
          return;
        }
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPartidos(widget.idCampeonato, false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GradientScaffold(
      floatingActionButton: SlideInRight(
        delay: const Duration(seconds: 1),
        child: FloatingActionButton(
          onPressed: () => context
              .push('/campeonatos/${widget.idCampeonato}/addPartido')
              .then((value) {
            //Solo si agrego un partido, refrescamos
            if (value != null) {
              fetchPartidos(widget.idCampeonato, partidos.isNotEmpty);
            }
          }),
          child: const Icon(Icons.add),
        ),
      ),
      showBackArrow: true,
      body: SizedBox(
        width: size.width,
        child: Column(
          children: [
            Text('Calendario', style: textStyles.titleMedium),
            const SizedBox(height: 15),
            loading
                ? Center(
                    child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.3),
                    child: const CircularProgressIndicator(color: Colors.white),
                  ))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Visibility(
                          visible: partidos.isEmpty,
                          child: Text(
                            '😢 No hay partidos programados aún.',
                            style: textStyles.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ...partidos.map(
                        (partido) => CardPartido(
                            p: partido,
                            size: size,
                            colors: colors,
                            textStyles: textStyles,
                            refreshState: () {
                              fetchPartidos(widget.idCampeonato, true);
                            }),
                      ),
                      const SizedBox(height: 30),
                      loadingWithPartidos
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Container()
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
