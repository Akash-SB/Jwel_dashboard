import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/app_routes.dart';
import 'package:sales_data_dashboard/theme.dart';

import '../../widgets/dashboard_content.dart';
import '../../widgets/sidebar.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  // late NavigationStore navStore;

  @override
  void initState() {
    super.initState();
    // if (!GetIt.I.isRegistered<NavigationStore>()) {
    //   GetIt.I.registerLazySingleton<NavigationStore>(() => NavigationStore());
    // }
    // navStore = GetIt.I<NavigationStore>();
  }

  @override
  void dispose() {
    // if (GetIt.I.isRegistered<NavigationStore>()) {
    //   GetIt.I.unregister<NavigationStore>();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 260.dp,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 30.dp,
                ),
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  title: Text("Onky Soerya N."),
                  subtitle: Text("Admin Manager"),
                ),
                const Divider(),
                _sidebarItem(Icons.dashboard, "Dashboard"),
                _sidebarItem(Icons.receipt_long, "Invoices"),
                _sidebarItem(Icons.settings, "Settings"),
              ],
            ),
          ),
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              initialRoute: AppRoutes.tabRoutes[0],
              onGenerateRoute: AppRoutes.generateRoute,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.grey,
      ),
      title: Text(label),
      hoverColor: AppColors.primary.withOpacity(0.1),
    );
  }
}
