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
          children: [
            Image.asset(
              imagePath,
              height: 24.dp,
              width: 24.dp,
            ),
            SizedBox(
              width: 8.dp,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
