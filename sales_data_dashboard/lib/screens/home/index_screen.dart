import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/app_routes.dart';
import 'package:sales_data_dashboard/theme.dart';

import '../../models/invoice_notification_model.dart';
import 'store/userdata_store.dart';

final getIt = GetIt.instance;

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
    if (!getIt.isRegistered<UserDataStore>(
      instanceName: 'UserDataStore',
    )) {
      getIt.registerSingleton<UserDataStore>(UserDataStore(),
          instanceName: 'UserDataStore');
    }
    userDataStore = getIt<UserDataStore>(
      instanceName: 'UserDataStore',
    );
    userDataStore.initialize();
    _fetchData();
  }

  Future<void> showNotification(
      final List<InvoiceNotificationModel> notfList) async {
    for (int i = 0; i < notfList.length; i++) {
      if (notfList[i].isShown == false) {
        final id = int.tryParse(notfList[i].id.toString()) ?? 0;
        final title = notfList[i].message;
        final body = 'Invoice ID: ${notfList[i].salesId}';

        await userDataStore.showNotification(
          id: id,
          title: title,
          body: body,
        );

        // Mark as shown after displaying notification
        notfList[i].isShown = true;
      }
    }
    // After showing notifications, update the list with the updated notfList
    userDataStore.updateNotifcations(notfList);
  }

  Future<void> _fetchData() async {
    await userDataStore.getAllData().onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching data: ${userDataStore.errorMessage}'),
        ),
      );
    });
    await showNotification(userDataStore.notfList);
    userDataStore.setIsAllDataLoaded(true);
  }

  final icons = [
    Icons.dashboard,
    Icons.receipt_long,
    Icons.bar_chart,
    Icons.shopping_cart,
    Icons.people,
    Icons.inventory,
    Icons.inventory_2,
  ];
  final labels = [
    "Dashboard",
    "Invoices",
    "Sales",
    "Purchase",
    "Party Details",
    "Stock Management",
    "Invoice Stock Management"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(
                    color: AppColors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.dp,
                  ),
                  Card(
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.top,
                      leading: CircleAvatar(
                        radius: 20.dp,
                        backgroundImage: const AssetImage('assets/logo.png'),
                      ),
                      title: Text(
                        "SAHAJANAND GEMS",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 10.dp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      subtitle: Text(
                        "Speciality All Kinds of Precious Stones",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 8.dp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.dp,
                  ),
                  Observer(builder: (context) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: labels.length,
                        itemBuilder: (context, index) {
                          return _sidebarItem(
                              icons[index], labels[index], index);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
            Observer(builder: (context) {
              return Expanded(
                child: userDataStore.isAllDataLoaded.value
                    ? Navigator(
                        key: _navigatorKey,
                        initialRoute: AppRoutes.dashboard,
                        onGenerateRoute: AppRoutes.generateRoute,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              );
            }),
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
            softWrap: true,
            overflow: TextOverflow.fade,
            maxLines: 1,
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
