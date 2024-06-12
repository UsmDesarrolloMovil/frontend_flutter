import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String placeHolder;
  final TextInputType inputType;
  final VoidCallback validator;
  const CustomTextInput({
    super.key,
    required this.controller,
    required this.label,
    required this.placeHolder,
    this.inputType = TextInputType.text,
    required this.validator,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            hintText: widget.placeHolder,
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
            // errorText: _errorText,
            errorStyle: TextStyle(
              color: colors.errorContainer,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: (value) => widget.validator(),
          onTap: () {
            // if (!_hasInitialValue && widget.controller.text.isEmpty) {
            //   setState(() {
            //     widget.controller.text = '0';
            //     _hasInitialValue = true;
            //   });
            // }
          },
        ),
      ],
    );
  }
}
