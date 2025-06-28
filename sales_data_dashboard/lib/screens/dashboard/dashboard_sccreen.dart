import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

import '../../theme.dart';

class DashboardSccreen extends StatelessWidget {
  const DashboardSccreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          SizedBox(height: 20.dp),
          _summaryCards(),
          SizedBox(height: 20.dp),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Dashboard",
          style: TextStyle(
            fontSize: 10.sp,
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

  Widget _summaryCards() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SummaryCard(title: "Overdue", value: "120.80 US\$"),
        SummaryCard(title: "Due soon", value: "0.00 US\$"),
        SummaryCard(title: "Avg. payment time", value: "24 days"),
        SummaryCard(title: "Upcoming Payout", value: "None"),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const SummaryCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Text(title, style: const TextStyle(color: AppColors.grey)),
              const SizedBox(height: 8),
              Text(value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
