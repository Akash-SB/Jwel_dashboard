import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool enabled;
  final int maxLines;
  final void Function(String)? onChanged;

  const CommonTextField({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        initialValue: controller == null ? initialValue : null,
        enabled: enabled,
        maxLines: maxLines,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 14,
          ),
          filled: true,
          fillColor: enabled ? Colors.white : const Color(0xFFF9FAFB),
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
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
      ),
    );
  }
}
