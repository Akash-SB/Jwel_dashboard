import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/screens/dashboard/dashboard_sccreen.dart';
import 'package:sales_data_dashboard/screens/home/index_screen.dart';
import 'package:sales_data_dashboard/screens/invoice/invoice_screen.dart';
import 'package:sales_data_dashboard/screens/settings/setting_screen.dart';
import 'package:sales_data_dashboard/screens/user_management/users_screen.dart';

import 'screens/products/view/products_screen.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String index = '/index';
  static const String invoices = '/invoices';
  static const String users = '/users';
  static const String products = '/products';
  static const String setting = '/setting';
  // static const String invoiceDetails = '/invoice/details';
  // static const String reports = '/reports';
  // static const String accounting = '/accounting';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final selectedRoute = switch (settings.name) {
      index => const IndexScreen(),
      dashboard => const DashboardSccreen(),
      invoices => const InvoiceScreen(),
      users => const UsersScreen(),
      products => const ProductsScreen(),
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
    products,
    setting,
  ];
}
