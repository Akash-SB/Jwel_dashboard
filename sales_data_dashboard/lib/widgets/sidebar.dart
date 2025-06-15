import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import '../theme.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      onTap: () {},
    );
  }
}
