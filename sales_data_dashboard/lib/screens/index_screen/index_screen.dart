import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/app_routes.dart';
import 'package:sales_data_dashboard/theme.dart';

import 'store/userdata_store.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late UserDataStore userDataStore;

  @override
  void initState() {
    super.initState();
    if (!GetIt.I.isRegistered<UserDataStore>()) {
      GetIt.I.registerLazySingleton<UserDataStore>(() => UserDataStore());
    }
    userDataStore = GetIt.I<UserDataStore>();
  }

  @override
  void dispose() {
    if (GetIt.I.isRegistered<UserDataStore>()) {
      GetIt.I.unregister<UserDataStore>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Row(
          children: [
            Container(
              width: 20.w,
              // color: Colors.white,
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
                  _sidebarItem(Icons.dashboard, "Dashboard", 0),
                  _sidebarItem(Icons.receipt_long, "Invoices", 1),
                  _sidebarItem(Icons.person_3_rounded, "Users", 2),
                  _sidebarItem(Icons.settings, "Settings", 3),
                ],
              ),
            ),
            Expanded(
              child: Navigator(
                key: _navigatorKey,
                initialRoute: AppRoutes.dashboard,
                onGenerateRoute: AppRoutes.generateRoute,
              ),
            ),
          ],
        );
      }),
    );
  }

  void _navigateTo(String route) {
    _navigatorKey.currentState?.pushReplacementNamed(route);
  }

  Widget _sidebarItem(IconData icon, String label, int index) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.grey,
      ),
      title: Text(label),
      hoverColor: AppColors.primary.withOpacity(0.1),
      onTap: () {
        _navigateTo(AppRoutes.tabRoutes[index]);
      },
    );
  }
}
