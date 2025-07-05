import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final bool isFilled;
  final Color filledColor;
  final Color borderColor;
  final Color textColor;
  final EdgeInsets? padding;

  const NormalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFilled = true,
    this.filledColor = const Color(0xFF2563EB),
    this.borderColor = const Color(0xFF2563EB),
    this.textColor = Colors.white,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled ? filledColor : Colors.white,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isFilled ? filledColor : borderColor,
              width: 2.dp,
            ),
          ),
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: 8.dp,
                horizontal: 16.dp,
              ),
          elevation: isFilled ? 2 : 0,
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                color: isFilled ? textColor : borderColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
