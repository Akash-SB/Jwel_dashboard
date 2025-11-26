import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/screens/dashboard/dashboard_sccreen.dart';
import 'package:sales_data_dashboard/screens/home/index_screen.dart';
import 'package:sales_data_dashboard/screens/invoice/invoice_screen.dart';
import 'package:sales_data_dashboard/screens/invoice_stock/view/invoice_stock_mgnt_screen.dart';
import 'package:sales_data_dashboard/screens/party_details/view/party_details_screen.dart';
import 'package:sales_data_dashboard/screens/payment/payment_screen.dart';
import 'package:sales_data_dashboard/screens/purchase/view/purchase_screen.dart';
import 'package:sales_data_dashboard/screens/sales/view/sales_screen.dart';
import 'package:sales_data_dashboard/screens/stock_management/view/stock_management_screen.dart';

import 'screens/home/home_screen.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String index = '/index';
  static const String invoices = '/invoices';
  static const String sales = '/sales';
  static const String purchase = '/purchase';
  static const String partyDetails = '/partyDetails';
  static const String stockMgmt = '/stockMgmt';
  static const String invoiceStock = '/invoiceStock';
  static const String payments = '/payments';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final selectedRoute = switch (settings.name) {
      index => const IndexScreen(),
      dashboard => const DashboardSccreen(),
      invoices =>
        InvoiceScreen(selectedFirm: settings.arguments as CompanyModel?),
      sales => const SalesScreen(),
      purchase => const PurchaseScreen(),
      partyDetails => const PartyDetailsScreen(),
      home => const HomeScreen(),
      stockMgmt => const StockManagementScreen(),
      payments => const PaymentScreen(),
      invoiceStock => const InvoiceStockMgntScreen(),
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
}
