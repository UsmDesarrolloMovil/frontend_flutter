import 'package:flutter/material.dart';

class ImageWithLoader extends StatelessWidget {
  final String imageUrl;

  const ImageWithLoader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder:
          'assets/loaders/loader_3.gif', // Ruta de la imagen del loader local
      image: imageUrl,
      height: double.infinity,
      fit: BoxFit.cover,
      placeholderFit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        return const Icon(
            Icons.error); // Mostrar un icono de error si la imagen no se carga
      },
    );
  }
}
