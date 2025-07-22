// common_dropdown.dart
import 'package:flutter/material.dart';

class CommonDropdown extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? value;
  final void Function(String?)? onChanged;

  const CommonDropdown({
    super.key,
    required this.label,
    this.options = const ['Option 1', 'Option 2'],
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        focusColor: Colors.transparent,
        padding: EdgeInsets.zero,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
        dropdownColor: Colors.white,
        items: options.map((opt) {
          return DropdownMenuItem(
            value: opt,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Text(opt),
            ),
          );
        }).toList(),
        onChanged: onChanged ?? (_) {},
      ),
    );
  }
}
