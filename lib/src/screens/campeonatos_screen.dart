import 'package:animate_do/animate_do.dart';
import 'package:esports_app/models/campeonato_model.dart';
import 'package:esports_app/src/services/services.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:esports_app/src/widgets/image_with_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_gradient.dart';

class CampeonatosScreen extends StatelessWidget {
  const CampeonatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      floatingActionButton: SlideInRight(
        delay: const Duration(seconds: 1),
        child: FloatingActionButton(
          onPressed: () => context.push('/addCampeonato'),
          child: const Icon(Icons.add),
        ),
      ),
      addPadding: false,
      appbarWidget: const Row(
        children: [
          Icon(
            MdiIcons.trophyAward,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text('Campeonatos'),
        ],
      ),
      body: FutureBuilder(
        future: CampeonatoService().getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          final data = snapshot.data;
          final campeonatos = List<Map<String, dynamic>>.from(data as List)
              .map((c) => CampeonatoModel.fromApi(c))
              .toList();
          return _ListaCampeonatos(campeonatos);
        },
      ),
    );
  }
}

class _ListaCampeonatos extends StatelessWidget {
  final List<CampeonatoModel> campeonatos;
  const _ListaCampeonatos(this.campeonatos);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: campeonatos.length,
        itemBuilder: (context, i) {
          final campeonato = campeonatos[i];

          return FadeInLeft(
            delay: Duration(milliseconds: 100 * i),
            child: Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    ImageWithLoader(imageUrl: campeonato.imgUrl),
                    const CustomGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.topRight,
                      stops: [0.2, 1.0],
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ],
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: Row(
                        children: [
                          const Icon(MdiIcons.trophy),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            campeonato.nombre,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 20,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.onError,
                        ),
                        onPressed: () =>
                            context.push('/campeonatos/${campeonato.id}'),
                        icon: const Icon(MdiIcons.eye),
                        label: const Text(
                          'Detalles',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
