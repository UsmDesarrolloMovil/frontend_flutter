import 'package:esports_app/models/equipo_model.dart';
import 'package:esports_app/src/services/equipos/equipos_service.dart';
import 'package:esports_app/src/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:go_router/go_router.dart';

class EquiposScreen extends StatelessWidget {
  const EquiposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
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
            //AGREGAR UN EQUIPO
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
}
