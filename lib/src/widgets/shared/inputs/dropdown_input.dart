import 'package:flutter/material.dart';

class DropdownInput<T> extends StatefulWidget {
  final List<T> list;
  final List<Widget> iconos;
  final String title;
  final ValueChanged<T?> onChanged;
  final T initialValue;

  const DropdownInput(
      {super.key,
      required this.list,
      required this.title,
      required this.iconos,
      required this.onChanged,
      required this.initialValue});

  @override
  State<DropdownInput<T>> createState() => _DropdownInputState<T>();
}

class _DropdownInputState<T> extends State<DropdownInput<T>> {
  late T dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colors.onError,
            borderRadius: BorderRadius.circular(8),
          ),
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<T>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward, color: Colors.white),
              dropdownColor: colors.onError,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.onError),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.onError),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: colors.onError,
              ),
              onChanged: (T? value) {
                setState(() {
                  dropdownValue = value!;
                });
                widget.onChanged(value);
              },
              items: List<DropdownMenuItem<T>>.generate(widget.list.length,
                  (index) {
                return DropdownMenuItem<T>(
                  value: widget.list[index],
                  child: Row(
                    children: [
                      widget.iconos[index],
                      const SizedBox(width: 8),
                      Text(
                        widget.list[index].toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
