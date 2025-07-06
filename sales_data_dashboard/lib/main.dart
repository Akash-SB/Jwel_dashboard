import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/firebase_options.dart';
import 'package:sales_data_dashboard/screens/home/index_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        home: const IndexScreen());
  }
}
