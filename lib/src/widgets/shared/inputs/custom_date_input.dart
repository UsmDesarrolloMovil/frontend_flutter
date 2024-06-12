import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (oldValue.text.length > newValue.text.length) {
      return newValue;
    }
    final buffer = StringBuffer();
    if (text.length >= 2) {
      buffer.write('${text.substring(0, 2)}-');
      if (text.length > 2) {
        if (text.length >= 4) {
          buffer.write('${text.substring(2, 4)}-');
          if (text.length > 4) {
            final end = text.length > 8 ? 8 : text.length;
            buffer.write(text.substring(4, end));
          }
        } else {
          buffer.write(text.substring(2));
        }
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

class CustomDateInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String?) validator;
  const CustomDateInput(
      {super.key,
      required this.label,
      required this.validator,
      required this.controller});

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  // final TextEditingController _controller = TextEditingController();
  String? _errorText;
  bool _hasInitialValue = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
    widget.controller.value.text;
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

  void _validateDate(String value) {
    setState(() {
      _errorText = null;
      final parts = value.split('-');
      if (parts.length != 3) {
        _errorText = 'Fecha no válida';
        return;
      }

      final day = int.tryParse(parts[0]) ?? 0;
      final month = int.tryParse(parts[1]) ?? 0;
      final year = int.tryParse(parts[2]) ?? 0;

      final errors = <String>[];

      if (day < 1 || day > 31) {
        errors.add('Día no válido');
      }
      if (month < 1 || month > 12) {
        errors.add('Mes no válido');
      }
      if (year < DateTime.now().year) {
        errors.add('Minimo año: ${DateTime.now().year}');
      }
      if (year > DateTime.now().year + 3) {
        errors.add('Maximo año: 2027');
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
          inputFormatters: [DateTextInputFormatter()],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            hintText: 'dd-mm-yyyy',
            hintStyle:
                TextStyle(fontSize: 16.0, color: Colors.white.withOpacity(.5)),
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
            errorText: _errorText,
            errorStyle: TextStyle(
              color: colors.errorContainer,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: _validateDate,
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
