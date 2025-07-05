import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class DashboardSccreen extends StatefulWidget {
  const DashboardSccreen({super.key});

  @override
  State<DashboardSccreen> createState() => _DashboardSccreenState();
}

class _DashboardSccreenState extends State<DashboardSccreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
        ],
      ),
    );
  }

  Widget _header() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Dashboard",
          style: TextStyle(
            color: Color(0xff1F2937),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {},
        //   child: const Text(
        //     "Create an Invoice",
        //   ),
        // )
      ],
    );
  }
}
