import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/user_management/store/customer_store.dart';

import '../../widgets/custom_data_table.dart';
import '../../widgets/stat_card_grid_widget.dart';

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
      getIt.registerFactory<CustomerStore>(
        () => CustomerStore(),
      );
    }
    customerStore = getIt<CustomerStore>();
  }

  @override
  void dispose() {
    getIt.unregister<CustomerStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> customerList = [
      {
        'name': 'Sophia Clark',
        'ssn': '555-1234',
        'gst': 'GST1234567890',
        'userType': 'Company',
        'address': '123 Innovation Drive, New York City',
        'days': 30,
      },
      {
        'name': 'Liam Walker',
        'ssn': '555-5678',
        'gst': 'GST9876543210',
        'userType': 'Broker',
        'address': '456 Trade Avenue, Commerce Town',
        'days': 60,
      },
      {
        'name': 'Olivia Hayes',
        'ssn': '555-9012',
        'gst': 'GST1122334455',
        'userType': 'Broker',
        'address': '789 Design Lane, Arts Center',
        'days': 45,
      },
      {
        'name': 'Sophia Clark',
        'ssn': '555-1234',
        'gst': 'GST1234567890',
        'userType': 'Company',
        'address': '123 Innovation Drive, New York City',
        'days': 30,
      },
      {
        'name': 'Liam Walker',
        'ssn': '555-5678',
        'gst': 'GST9876543210',
        'userType': 'Company',
        'address': '456 Trade Avenue, Commerce Town',
        'days': 60,
      },
      {
        'name': 'Olivia Hayes',
        'ssn': '555-9012',
        'gst': 'GST1122334455',
        'userType': 'Broker',
        'address': '789 Design Lane, Arts Center',
        'days': 45,
      },
      {
        'name': 'Liam Walker',
        'ssn': '555-5678',
        'gst': 'GST9876543210',
        'userType': 'Broker',
        'address': '456 Trade Avenue, Commerce Town',
        'days': 60,
      },
      {
        'name': 'Olivia Hayes',
        'ssn': '555-9012',
        'gst': 'GST1122334455',
        'userType': 'Broker',
        'address': '789 Design Lane, Arts Center',
        'days': 45,
      },
      {
        'name': 'Sophia Clark',
        'ssn': '555-1234',
        'gst': 'GST1234567890',
        'userType': 'Company',
        'address': '123 Innovation Drive, New York City',
        'days': 30,
      },
      {
        'name': 'Liam Walker',
        'ssn': '555-5678',
        'gst': 'GST9876543210',
        'userType': 'Company',
        'address': '456 Trade Avenue, Commerce Town',
        'days': 60,
      },
      {
        'name': 'Olivia Hayes',
        'ssn': '555-9012',
        'gst': 'GST1122334455',
        'userType': 'Broker',
        'address': '789 Design Lane, Arts Center',
        'days': 45,
      },
      {
        'name': 'Liam Walker',
        'ssn': '555-5678',
        'gst': 'GST9876543210',
        'userType': 'Broker',
        'address': '456 Trade Avenue, Commerce Town',
        'days': 60,
      },
      {
        'name': 'Olivia Hayes',
        'ssn': '555-9012',
        'gst': 'GST1122334455',
        'userType': 'Broker',
        'address': '789 Design Lane, Arts Center',
        'days': 45,
      },
      {
        'name': 'Sophia Clark',
        'ssn': '555-1234',
        'gst': 'GST1234567890',
        'userType': 'Company',
        'address': '123 Innovation Drive, New York City',
        'days': 30,
      },
      {
        'name': 'Liam Walker',
        'ssn': '555-5678',
        'gst': 'GST9876543210',
        'userType': 'Company',
        'address': '456 Trade Avenue, Commerce Town',
        'days': 60,
      },
      {
        'name': 'Olivia Hayes',
        'ssn': '555-9012',
        'gst': 'GST1122334455',
        'userType': 'Broker',
        'address': '789 Design Lane, Arts Center',
        'days': 45,
      },
      // Add more items as needed
    ];

    String searchKey = '';
    String selectedFilter = 'All';

    void clearFilters() {
      setState(() {
        searchKey = '';
        selectedFilter = 'All';
      });
    }

    final List<TableColumn> columns = [
      TableColumn(label: 'Customer Name', key: 'name', isSortable: true),
      TableColumn(label: 'SSN Number', key: 'ssn'),
      TableColumn(label: 'GST Number', key: 'gst'),
      TableColumn(label: 'User Type', key: 'userType'),
      TableColumn(label: 'Address', key: 'address'),
      TableColumn(label: 'Days of Interest', key: 'days', isSortable: true),
      TableColumn(label: 'Actions', key: 'actions', isAction: true),
    ];

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.dp,
          ),
          Row(
            children: [
              Text(
                "Users Management",
                style: TextStyle(
                  color: const Color(0xff1F2937),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.dp),
          Expanded(
            child: CustomDataTable(
              columns: columns,
              data: customerList,
              clearSearchKey: searchKey,
              clearSelectedFilter: selectedFilter,
              resetPaginationAndSorting: true,
              filterOptions: ['Broker', 'Company'],
              onEdit: (row) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Edit ${row['name']}')),
              ),
              onDelete: (row) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Delete ${row['name']}')),
              ),
              onExportPDF: () {},
              onExportExcel: () {},
            ),
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
          "Users Management",
          style: TextStyle(
            color: const Color(0xff1F2937),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text(
            "Add New User",
          ),
        )
      ],
    );
  }
}
