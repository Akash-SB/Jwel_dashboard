import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/screens/dashboard_screen.dart/dashboard_sccreen.dart';
import 'package:sales_data_dashboard/screens/index_screen/index_screen.dart';
import 'package:sales_data_dashboard/screens/invoice_screen.dart/invoice_screen.dart';
import 'package:sales_data_dashboard/screens/setting_screen/setting_screen.dart';

import 'screens/user_management_screen.dart/user_management_screen.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String index = '/index';
  static const String invoices = '/invoices';
  static const String users = '/users';
  static const String setting = '/setting';
  // static const String invoiceDetails = '/invoice/details';
  // static const String reports = '/reports';
  // static const String accounting = '/accounting';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final selectedRoute = switch (settings.name) {
      index => const IndexScreen(),
      dashboard => const DashboardSccreen(),
      invoices => const InvoiceScreen(),
      users => const UserManagementScreen(),
      setting => const SettingScreen(),
      _ => const DashboardSccreen()
    };

    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => selectedRoute,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static List<String> tabRoutes = [
    dashboard,
    invoices,
    users,
    setting,
  ];
}
