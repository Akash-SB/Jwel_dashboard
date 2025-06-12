import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import '../theme.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

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
          _invoiceTable(),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Invoices",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            "Create an Invoice",
          ),
        )
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

  Widget _invoiceTable() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _tableHeader(),
            const Divider(),
            _invoiceRow("INV842004", "Paid", "25 Jul 2021", "Jackson Balabala",
                "200.00", "0.00"),
            _invoiceRow("INV842007", "Overdue", "18 Jul 2021",
                "Clarisa Hercules", "840.00", "840.00"),
            _invoiceRow("INV842005", "Draft", "20 Jul 2021", "Claudia Emmay",
                "45.00", "45.00"),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader() {
    return const Row(
      children: [
        Expanded(child: Text("Number")),
        Expanded(child: Text("Status")),
        Expanded(child: Text("Date")),
        Expanded(child: Text("Customer")),
        Expanded(child: Text("Total")),
        Expanded(child: Text("Due")),
      ],
    );
  }

  Widget _invoiceRow(String number, String status, String date, String customer,
      String total, String due) {
    Color statusColor;
    switch (status) {
      case "Paid":
        statusColor = AppColors.success;
        break;
      case "Overdue":
        statusColor = AppColors.danger;
        break;
      case "Draft":
      default:
        statusColor = AppColors.grey;
    }

    return Row(
      children: [
        Expanded(child: Text(number)),
        Expanded(
          child: Text(status,
              style:
                  TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
        ),
        Expanded(child: Text(date)),
        Expanded(child: Text(customer)),
        Expanded(child: Text("\$${total}")),
        Expanded(child: Text("\$${due}")),
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
