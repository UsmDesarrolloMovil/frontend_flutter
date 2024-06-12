import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HourTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remover caracteres no numéricos
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Permitir borrar caracteres
    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }

    final buffer = StringBuffer();
    if (text.length >= 2) {
      // Agregar ":" después de los primeros dos dígitos
      buffer.write('${text.substring(0, 2)}:');
      if (text.length > 2) {
        // Agregar el resto de los caracteres (minutos)
        final end = text.length > 4 ? 4 : text.length;
        buffer.write(text.substring(2, end));
      }
    } else {
      buffer.write(text);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class CustomHourInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String?) validator;
  const CustomHourInput({
    super.key,
    required this.label,
    required this.validator,
    required this.controller,
  });

  @override
  State<CustomHourInput> createState() => _CustomHourInputState();
}

class _CustomHourInputState extends State<CustomHourInput> {
  String? _errorText;
  bool _hasInitialValue = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTextChange);
    widget.controller.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    if (!_hasInitialValue && widget.controller.text.isNotEmpty) {
      _hasInitialValue = true;
    }
  }

  void _validateHour(String value) {
    setState(() {
      _errorText = null;
      final parts = value.split(':');
      if (parts.length != 2) {
        _errorText = 'Hora no válida';
        return;
      }

      final hour = int.tryParse(parts[0]) ?? 0;
      final minute = int.tryParse(parts[1]) ?? 0;

      final errors = <String>[];

      if (hour < 0 || hour > 23) {
        errors.add('Hora no válida');
      }
      if (minute < 0 || minute > 59) {
        errors.add('Minuto no válido');
      }

      if (errors.isNotEmpty) {
        _errorText = errors.join(', ');
      }
    });

    widget.validator(_errorText);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          inputFormatters: [HourTextInputFormatter()],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colors.onError,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colors.onError,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colors.onError,
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colors.onError,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: colors.onError,
                width: 2.0,
              ),
            ),
            hintText: 'hh:mm',
            hintStyle:
                TextStyle(fontSize: 16.0, color: Colors.white.withOpacity(.5)),
            errorText: _errorText,
            errorStyle: TextStyle(
              color: colors.errorContainer,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: _validateHour,
          onTap: () {
            if (!_hasInitialValue && widget.controller.text.isEmpty) {
              setState(() {
                widget.controller.text = '0';
                _hasInitialValue = true;
              });
            }
          },
        ),
      ],
    );
  }
}
