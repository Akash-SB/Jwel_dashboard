import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/screens/dashboard/dashboard_sccreen.dart';
import 'package:sales_data_dashboard/screens/home/index_screen.dart';
import 'package:sales_data_dashboard/screens/invoice/invoice_screen.dart';
import 'package:sales_data_dashboard/screens/invoice_stock/view/invoice_stock_mgnt_screen.dart';
import 'package:sales_data_dashboard/screens/party_details/view/party_details_screen.dart';
import 'package:sales_data_dashboard/screens/purchase/view/purchase_screen.dart';
import 'package:sales_data_dashboard/screens/sales/view/sales_screen.dart';
import 'package:sales_data_dashboard/screens/stock_management/view/stock_management_screen.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String index = '/index';
  static const String invoices = '/invoices';
  static const String sales = '/sales';
  static const String purchase = '/purchase';
  static const String partyDetails = '/partyDetails';
  static const String stockMgmt = '/stockMgmt';
  static const String invoiceStock = '/invoiceStock';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final selectedRoute = switch (settings.name) {
      index => const IndexScreen(),
      dashboard => const DashboardSccreen(),
      invoices => const InvoiceScreen(),
      sales => const SalesScreen(),
      purchase => const PurchaseScreen(),
      partyDetails => const PartyDetailsScreen(),
      stockMgmt => const StockManagementScreen(),
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

  static List<String> tabRoutes = [
    dashboard,
    partyDetails,
    stockMgmt,
    sales,
    purchase,
    invoices,
  ];
}
