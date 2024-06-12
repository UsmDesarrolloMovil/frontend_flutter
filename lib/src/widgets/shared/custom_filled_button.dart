import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget widgetText;
  final bool animated;
  final bool fullWidth;
  final bool disabled;
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.widgetText,
    this.disabled = false,
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
        disabledBackgroundColor: colors.onError.withOpacity(.5),
        padding: EdgeInsets.symmetric(
          vertical: 17,
          horizontal: fullWidth ? 0 : 10,
        ),
      ),
      onPressed: disabled ? null : onPressed,
      child: widgetText,
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
