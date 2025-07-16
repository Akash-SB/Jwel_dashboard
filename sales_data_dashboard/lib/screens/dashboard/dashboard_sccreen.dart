import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/screens/dashboard/store/activity_store.dart';

import '../../dummy_generated_data.dart';
import '../../models/app_enum.dart';
import '../../models/invoice_notification_model.dart';
import '../../services/notification_checker_services.dart';
import '../../services/notification_db_services.dart';
import '../home/store/userdata_store.dart';

final getIt = GetIt.instance;

class DashboardSccreen extends StatefulWidget {
  const DashboardSccreen({super.key});

  @override
  State<DashboardSccreen> createState() => _DashboardSccreenState();
}

class _DashboardSccreenState extends State<DashboardSccreen> {
  late UserDataStore userDataStore;
  late ActivityStore activityStore;
  List<InvoiceNotificationModel> notf = [];

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
    Activity(
        date: DateTime(2024, 2, 18),
        title: 'New client account created',
        amount: null),
    Activity(
        date: DateTime(2024, 2, 18),
        title: 'Supplier payment processed',
        amount: -3200.00),
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
  void initState() {
    super.initState();
    if (!getIt.isRegistered<UserDataStore>()) {
      getIt.registerSingleton<UserDataStore>(UserDataStore());
    }
    userDataStore = GetIt.I<UserDataStore>();
    if (!getIt.isRegistered<ActivityStore>()) {
      getIt.registerSingleton<ActivityStore>(ActivityStore());
    }
    activityStore = getIt<ActivityStore>();
    if (userDataStore.invoices.isEmpty) {
      activityStore.fetchInvoices();
      userDataStore.setInvoices(activityStore.invoices);
    } else {
      activityStore.setInvoices(userDataStore.invoices);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationCheckerService.checkInvoicesForToday(activityStore.invoices);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Dashboard Management',
          style: TextStyle(
            fontSize: 20.dp,
            fontWeight: FontWeight.bold,
            color: const Color(
              0xFF111827,
            ),
          ),
        ),
        actions: [
          Observer(
            builder: (context) => InkWell(
              splashColor: Colors.white,
              hoverColor: Colors.white,
              highlightColor: Colors.white,
              focusColor: Colors.white,
              onTap: () async {
                notf = await NotificationDBService.getAllNotifications();
                Scaffold.of(context).openEndDrawer();
              },
              child: Container(
                padding: EdgeInsets.all(
                  8.dp,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF6B7280),
                  ),
                ),
                child: Image.asset(
                  width: 16.dp,
                  height: 16.dp,
                  'assets/icons/notf_icon.png',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16.dp,
          ),
        ],
      ),
      endDrawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Observer(builder: (context) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(
                        0xFFE5E7EB,
                      ),
                    ),
                  ),
                ),
                padding: EdgeInsets.all(16.dp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/notf_icon.png',
                      width: 20.dp,
                      height: 20.dp,
                    ),
                    SizedBox(
                      width: 8.dp,
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 18.dp,
                        color: const Color(0xFF111827),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(18.dp),
                  color: const Color.fromARGB(255, 239, 240, 241),
                  child: ListView.builder(
                    itemCount: notf.length,
                    itemBuilder: (ctx, index) {
                      final notif = notf[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              await NotificationDBService.markAsRead(notif.id);
                              Navigator.pop(context);
                              // Optionally refresh UI
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                12.dp,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 200, 203, 210),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    8.dp,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          notif.message,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 12.dp,
                                            color: const Color(0xFF111827),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      notif.isRead
                                          ? Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 16.dp,
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.dp,
                                  ),
                                  Text(
                                    notif.userId,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 11.dp,
                                      color: const Color(0xFF4B5563),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.dp,
                                  ),
                                  Text(
                                    'Invoice : ${notif.invoiceId}',
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 11.dp,
                                      color: const Color(0xFF4B5563),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.dp,
                                  ),
                                  Text(
                                    '${notif.notifyDate.day}/${notif.notifyDate.month}/${notif.notifyDate.year}',
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 10.dp,
                                      color: const Color(0xFF6B7280),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.dp,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(24.dp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sales vs Purchase Analysis',
                style: TextStyle(
                  fontSize: 18.dp,
                  color: const Color(0xFF111827),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Last 6 Months Transaction Overview',
                style: TextStyle(
                  fontSize: 12.dp,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 12.dp,
              ),
              SizedBox(
                height: 400.dp,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Observer(builder: (context) {
                      final monthlyData =
                          getMonthlyTotals(userDataStore.sixMonthTxnList);

                      return Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: BarChart(
                            buildBarChartData(monthlyData),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 4.dp,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.dp,
                          horizontal: 8.dp,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFF3F4F6),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.dp,
                            ),
                          ),
                        ),
                        child: ListView.separated(
                          itemCount: activities.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(
                              0xFFF3F4F6,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final activity = activities[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('yyyy-MM-dd')
                                        .format(activity.date),
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(activity.title,
                                      style: const TextStyle(fontSize: 14)),
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
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.dp),
              Observer(
                  builder: (context) =>
                      buildSummaryCards(userDataStore.sixMonthTxnList)),
            ],
          ),
        ),
      ),
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
      children: [
        Flexible(
          child: _SummaryCard(
            title: 'Total Sales',
            amount: totalSales,
            color: Colors.green,
          ),
        ),
        SizedBox(
          width: 24.dp,
        ),
        Flexible(
          child: _SummaryCard(
            title: 'Total Purchases',
            amount: totalPurchase,
            color: Colors.orange,
          ),
        ),
        SizedBox(
          width: 24.dp,
        ),
        Flexible(
          child: _SummaryCard(
            title: 'Net Difference',
            amount: net,
            color: Colors.blue,
          ),
        ),
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
      gridData: const FlGridData(
        drawVerticalLine: false,
      ),
      barTouchData: BarTouchData(
        enabled: false,
      ),
      borderData: FlBorderData(
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      barGroups: barGroups,
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        rightTitles: const AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < monthlyData.length) {
                return Text(
                  monthlyData.keys.elementAt(index),
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                );
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

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 16.dp,
        horizontal: 16.dp,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(
            0xFFE5E7EB,
          ),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.dp),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.dp,
              color: const Color(
                0xFF4B5563,
              ),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.dp),
          Text(
            "\₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
              color: color,
              fontSize: 24.dp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RecentActivityCard extends StatelessWidget {
  final List<Activity> activities;

  const RecentActivityCard({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Activities',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.dp,
            ),
          ),
          SizedBox(height: 16.dp),
          ...activities.map((activity) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd').format(activity.date),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.dp,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(activity.title, style: const TextStyle(fontSize: 14)),
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
    );
  }
}

class Activity {
  final DateTime date;
  final String title;
  final double? amount;

  Activity({required this.date, required this.title, this.amount});
}
