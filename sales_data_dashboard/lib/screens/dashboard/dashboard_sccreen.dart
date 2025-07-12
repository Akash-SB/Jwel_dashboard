import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';

import '../../dummy_generated_data.dart';
import '../../models/app_enum.dart';

class DashboardSccreen extends StatefulWidget {
  const DashboardSccreen({super.key});

  @override
  State<DashboardSccreen> createState() => _DashboardSccreenState();
}

class _DashboardSccreenState extends State<DashboardSccreen> {
  final List<InvoiceModel> transactions = generateDummyTransactions();

  final List<Activity> activities = [
    Activity(
        date: DateTime(2024, 2, 20),
        title: 'New invoice #INV-2024-002',
        amount: 2450.00),
    Activity(
        date: DateTime(2024, 2, 19),
        title: 'Payment received from John Corp',
        amount: 1850.00),
    Activity(
        date: DateTime(2024, 2, 19),
        title: 'New product added: Premium Package',
        amount: null),
    Activity(
        date: DateTime(2024, 2, 18),
        title: 'New client account created',
        amount: null),
    Activity(
        date: DateTime(2024, 2, 18),
        title: 'Supplier payment processed',
        amount: -3200.00),
  ];

  @override
  Widget build(BuildContext context) {
    final monthlyData = getMonthlyTotals(transactions);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              300, // Set fixed height to avoid layout issues
                          child: BarChart(buildBarChartData(monthlyData)),
                        ),
                        const SizedBox(height: 20),
                        buildSummaryCards(transactions),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RecentActivityCard(activities: activities),
                ),
              ],
            ),
          ],
        ),
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

  Widget buildSummaryCards(List<InvoiceModel> transactions) {
    final totalSales = transactions
        .where((t) => t.transactionType == TransactionTypeEnum.sell)
        .fold(0.0, (prev, e) => prev + e.parsedAmount);

    final totalPurchase = transactions
        .where((t) => t.transactionType == TransactionTypeEnum.purchase)
        .fold(0.0, (prev, e) => prev + e.parsedAmount);

    final net = totalSales - totalPurchase;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SummaryCard(
            title: 'Total Sales', amount: totalSales, color: Colors.green),
        _SummaryCard(
            title: 'Total Purchases',
            amount: totalPurchase,
            color: Colors.orange),
        _SummaryCard(title: 'Net Difference', amount: net, color: Colors.blue),
      ],
    );
  }

  BarChartData buildBarChartData(Map<String, Map<String, double>> monthlyData) {
    final barGroups = <BarChartGroupData>[];
    int index = 0;

    monthlyData.forEach((month, data) {
      barGroups.add(
        BarChartGroupData(
          x: index++,
          barRods: [
            BarChartRodData(
              toY: data['sell']!,
              color: const Color(0xFF22C55E),
              width: 14.dp,
              borderRadius: const BorderRadius.all(
                Radius.zero,
              ),
            ),
            BarChartRodData(
              toY: data['purchase']!,
              color: const Color(0xFFF97316),
              borderRadius: const BorderRadius.all(
                Radius.zero,
              ),
              width: 14.dp,
            ),
          ],
        ),
      );
    });

    return BarChartData(
      barGroups: barGroups,
      titlesData: FlTitlesData(
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < monthlyData.length) {
                return Text(monthlyData.keys.elementAt(index),
                    style: const TextStyle(fontSize: 10));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Map<String, Map<String, double>> getMonthlyTotals(
      List<InvoiceModel> transactions) {
    final now = DateTime.now();
    final result = <String, Map<String, double>>{};

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final key = "${month.month.toString().padLeft(2, '0')}/${month.year}";
      result[key] = {"sell": 0.0, "purchase": 0.0};
    }

    for (var tx in transactions) {
      final date = DateTime.tryParse(tx.date);
      if (date == null) continue;

      final key = "${date.month.toString().padLeft(2, '0')}/${date.year}";
      if (result.containsKey(key)) {
        final type = tx.transactionType == TransactionTypeEnum.sell
            ? "sell"
            : "purchase";
        result[key]![type] = result[key]![type]! + tx.parsedAmount;
      }
    }

    return result;
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;

  const _SummaryCard(
      {required this.title, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("\$${amount.toStringAsFixed(2)}",
                style: TextStyle(color: color, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class RecentActivityCard extends StatelessWidget {
  final List<Activity> activities;

  const RecentActivityCard({required this.activities});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activities',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            ...activities.map((activity) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('yyyy-MM-dd').format(activity.date),
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(activity.title, style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(
                        activity.amount != null
                            ? "${activity.amount! >= 0 ? "+" : "-"}\$${activity.amount!.abs().toStringAsFixed(2)}"
                            : "-",
                        style: TextStyle(
                          color: activity.amount == null
                              ? Colors.orange
                              : activity.amount! >= 0
                                  ? Colors.green
                                  : Colors.deepOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class Activity {
  final DateTime date;
  final String title;
  final double? amount;

  Activity({required this.date, required this.title, this.amount});
}
