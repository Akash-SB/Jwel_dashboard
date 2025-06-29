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
              width: 15.w,
              padding: EdgeInsets.symmetric(horizontal: 16.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.dp,
                  ),
                  const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                      child: Icon(Icons.assignment_ind_outlined,
                          color: Colors.white),
                    ),
                    title: Text("AdminPRO"),
                  ),
                  SizedBox(
                    height: 30.dp,
                  ),
                  Observer(builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final icons = [
                            Icons.dashboard,
                            Icons.receipt_long,
                            Icons.person_3_rounded,
                            Icons.inventory_2,
                            Icons.settings,
                          ];
                          final labels = [
                            "Dashboard",
                            "Invoices",
                            "Users",
                            "Products",
                            "Settings",
                          ];
                          return _sidebarItem(
                              icons[index], labels[index], index);
                        },
                      ),
                    );
                  }),
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
    return Observer(
      builder: (context) {
        final isSelected = userDataStore.tabIndex == index;
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: Icon(
            icon,
            color: isSelected ? const Color(0xFF2563EB) : AppColors.grey,
          ),
          title: Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF2563EB) : AppColors.grey,
            ),
          ),
          hoverColor: AppColors.primary.withOpacity(0.1),
          onTap: () {
            userDataStore.setTab(index);
            _navigateTo(AppRoutes.tabRoutes[index]);
          },
          selected: isSelected,
          selectedTileColor: const Color(0xFFEFF6FF),
        );
      },
    );
  }
}
