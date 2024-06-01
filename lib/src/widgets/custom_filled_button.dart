import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return SlideInUp(
      delay: const Duration(milliseconds: 400),
      child: SizedBox(
        width: size.width,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colors.onError,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 17),
          ),
          onPressed: () {},
          child: const Text('Continuar'),
        ),
      ),
    );
  }
}
