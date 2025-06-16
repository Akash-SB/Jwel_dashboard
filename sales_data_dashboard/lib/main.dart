import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/screens/index_screen/index_screen.dart';
import 'package:sales_data_dashboard/screens/login_screen/view/login_screen.dart';
import 'theme.dart';

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
        home: LoginScreen());
  }
}
