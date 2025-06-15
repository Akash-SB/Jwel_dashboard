import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/screens/dashboard_screen.dart/dashboard_sccreen.dart';
import 'package:sales_data_dashboard/screens/index_screen/index_screen.dart';
import 'package:sales_data_dashboard/screens/invoice_screen.dart/invoice_screen.dart';
import 'package:sales_data_dashboard/screens/setting_screen/setting_screen.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String invoices = '/invoices';
  static const String setting = '/setting';
  // static const String invoiceDetails = '/invoice/details';
  // static const String reports = '/reports';
  // static const String accounting = '/accounting';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardSccreen());
      case invoices:
        return MaterialPageRoute(builder: (_) => const InvoiceScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingScreen());

      default:
        return MaterialPageRoute(builder: (_) => const IndexScreen());
    }
  }

  static List<String> tabRoutes = [
    dashboard,
    invoices,
    setting,
  ];
}
