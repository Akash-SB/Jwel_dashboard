import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String title;
  final Color? activeColor;
  final TextStyle? textStyle;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.activeColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(activeColor ?? Colors.blueAccent),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
      child: RadioListTile<T>(
        title: Text(title, style: textStyle),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        hoverColor: Colors.transparent,
      ),
    );
  }
}
