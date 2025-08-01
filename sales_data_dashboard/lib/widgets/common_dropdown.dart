import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class CommonDropdown extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CommonDropdown({
    super.key,
    required this.label,
    this.options = const ['Option 1', 'Option 2'],
    this.value,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        validator: validator,
        value: value,
        padding: EdgeInsets.zero,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF000000),
          ),
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.dp),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.dp),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.dp),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),
        items: options.map((opt) {
          return DropdownMenuItem(
            value: opt,
            child: Text(
              opt,
              style: TextStyle(
                fontSize: 14,
                color: (value != null && value == opt)
                    ? Colors.blueAccent
                    : const Color(0xFF4B5563),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged ?? (_) {},
      ),
    );
  }
}
