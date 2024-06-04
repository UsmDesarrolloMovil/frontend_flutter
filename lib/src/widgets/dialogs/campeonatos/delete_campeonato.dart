import 'package:esports_app/src/services/campeonatos/campeonatos_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void deleteCampeonato(BuildContext context, int idCampeonato) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Borrar campeonato'),
        content: const Text('Deseas eliminar este campeonato?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text('Borrar'),
              onPressed: () {
                CampeonatoService().deleteCampeonato(idCampeonato).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Campeonato Borrado')),
                  );
                  context.pop();
                  context.pop();
                  context.pop();
                  context.pop();
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                });
              }),
        ],
      );
    },
  );
}
