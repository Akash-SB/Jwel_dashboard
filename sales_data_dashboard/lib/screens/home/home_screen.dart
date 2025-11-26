import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(40.sp),
      child: Center(
        child: Text(
          'Sahajanand Jwellers / Harikrishna Interprises Dashboard',
          style: TextStyle(
              fontSize: 24.sp,
              letterSpacing: 1.2.sp,
              fontWeight: FontWeight.w800),
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }
}
