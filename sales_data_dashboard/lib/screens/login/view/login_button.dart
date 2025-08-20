import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.dp),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.dp)),
        backgroundColor: const Color(0xFF3B82F6),
      ),
      onPressed: onPressed,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.dp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
 