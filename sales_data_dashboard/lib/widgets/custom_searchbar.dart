import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = "Search here...",
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        8.dp,
      ),
      borderSide: const BorderSide(
        color: Color(0xFFE5E7EB),
      ),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 12.dp,
        color: const Color(
          0xFF4B5563,
        ),
      ),
      decoration: InputDecoration(
        focusColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.dp,
          vertical: 8.dp,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.dp,
          color: const Color(0xFF9CA3AF),
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(
            0xFF9CA3AF,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}
