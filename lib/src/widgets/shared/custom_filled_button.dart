import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool animated;
  final bool fullWidth;
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.animated = false,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final Widget button = FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: colors.onError,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 17,
          horizontal: fullWidth ? 0 : 10,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
    return SlideInUp(
      child: fullWidth
          ? SizedBox(
              width: size.width,
              child: button,
            )
          : button,
    );
  }
}
