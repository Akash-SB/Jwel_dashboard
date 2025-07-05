import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/customer_model.dart';
import 'package:sales_data_dashboard/screens/user_management/store/customer_store.dart';
import 'package:sales_data_dashboard/screens/user_management/user_data_table.dart';
import 'package:sales_data_dashboard/screens/user_management/user_form.dart';

final getIt = GetIt.instance;

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late CustomerStore customerStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<CustomerStore>()) {
      getIt.registerFactory<CustomerStore>(() => CustomerStore());
    }
    customerStore = getIt<CustomerStore>();
    customerStore.initializeSearchController();
    customerStore
        .fetchCustomers(); // Fetch users from Firestore or your backend
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          SizedBox(height: 24.dp),
          Expanded(
            child: Observer(builder: (context) {
              return UsersDataTable(
                data: customerStore.customers, // List<CustomerModel>
                onDelete: (customer) => _confirmDelete(context, customer),
                onEdit: (customer) => _openUserForm(context, customer),
                onExportPDF: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting to PDF...')),
                  );
                },
                onExportExcel: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting to Excel...')),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "User Management",
          style: TextStyle(
            color: const Color(0xff1F2937),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () => _openUserForm(context),
          child: const Text(
            "Create a User",
          ),
        )
      ],
    );
  }

  void _openUserForm(BuildContext context, [CustomerModel? existingUser]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => CustomerForm(
        existingCustomer: existingUser,
        onSubmit: (userData) {
          if (existingUser == null) {
            customerStore.addCustomer(userData);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Customer ${userData.custName} added')),
            );
          } else {
            customerStore.updateCustomer(userData.id.toString(), userData);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Customer ${userData.custName} updated')),
            );
          }
          Navigator.pop(context);
          customerStore.fetchCustomers();
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, CustomerModel customer) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Customer'),
        content: Text(
            'Are you sure you want to delete customer ${customer.custName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              customerStore.deleteCustomer(customer.id.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Customer ${customer.custName} deleted')),
              );
              customerStore.fetchCustomers();
              Navigator.pop(ctx);
            },
            child: Text('Yes, Delete'),
          ),
        ],
      ),
    );
  }
}
