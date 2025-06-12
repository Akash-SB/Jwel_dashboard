import 'package:flutter/material.dart';
import 'theme.dart';
import 'widgets/sidebar.dart';
import 'widgets/dashboard_content.dart';

void main() {
  runApp(const InvoiceDashboardApp());
}

class InvoiceDashboardApp extends StatelessWidget {
  const InvoiceDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice Dashboard',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Scaffold(
        body: Row(
          children: [
            Sidebar(),
            Expanded(child: DashboardContent()),
          ],
        ),
      ),
    );
  }
}
