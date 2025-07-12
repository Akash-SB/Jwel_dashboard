import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class CustomImageButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color borderColor;
  final Color buttonColor;
  final Function()? onClicked;

  const CustomImageButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.borderColor,
    required this.buttonColor,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.dp,
          vertical: 8.dp,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(
            8.dp,
          ),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 16.dp,
              width: 16.dp,
            ),
            SizedBox(
              width: 8.dp,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.dp,
                color: const Color(0xFF111827),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
