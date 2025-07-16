import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/firebase_options.dart';
import 'package:sales_data_dashboard/screens/home/index_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'services/notification_service.dart';
import 'theme.dart';

void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initialize();
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
      home: const IndexScreen(),
    );
  }
}
