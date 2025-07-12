import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/user_management/show_user_info.dart';
import 'package:sales_data_dashboard/screens/user_management/store/customer_store.dart';
import 'package:sales_data_dashboard/screens/user_management/user_form.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

import '../../models/customer_model.dart';
import '../../widgets/custom_image_button.dart';
import '../../widgets/filter_dropdown_button.dart';
import '../../widgets/normal_button.dart';

final getIt = GetIt.instance;

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late CustomerStore customerStore;
  late UserDataStore userDataStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<CustomerStore>()) {
      getIt.registerFactory<CustomerStore>(() => CustomerStore());
    }

    if (!GetIt.I.isRegistered<UserDataStore>()) {
      GetIt.I.registerSingleton<UserDataStore>(UserDataStore());
    }
    userDataStore = GetIt.I<UserDataStore>();
    customerStore = getIt<CustomerStore>();
    customerStore.initializeSearchController();
    if (userDataStore.customers.isEmpty) {
      customerStore.fetchCustomers();
      userDataStore.setCustomers(customerStore.customers);
    } else {
      customerStore.setCustomers(userDataStore.customers);
    }
    customerStore.calculateTotalPages();
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Customer Id', key: 'id', isSortable: true),
      TableColumn(label: 'Customer Name', key: 'name', isSortable: true),
      TableColumn(label: 'User Type', key: 'userType'),
      TableColumn(label: 'GST Number', key: 'gst'),
      TableColumn(label: 'Mobile Number', key: 'mobile', isSortable: true),
      TableColumn(label: 'Address', key: 'address'),
      TableColumn(label: 'Actions', key: 'actions', isAction: true),
    ];
    return Observer(builder: (context) {
      return !customerStore.isToggle
          ? Container(
              color: Colors.white,
              padding: EdgeInsets.all(24.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'User Management',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(
                              0xFF111827,
                            ),
                          ),
                        ),
                        IntrinsicWidth(
                          child: NormalButton(
                            text: 'Add New User',
                            onPressed: () => _openForm(context),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 12.dp),
                  SizedBox(
                    width: double.infinity,
                    child: Divider(
                      thickness: 1.dp,
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  SizedBox(height: 24.dp),
                  Observer(builder: (context) {
                    return SizedBox(
                      height: 40.dp,
                      child: Row(
                        children: [
                          FilterDropdownButton(
                            selectedValue: customerStore.selectedUserType,
                            onChanged: (final value) {
                              customerStore.setSelectedUserType(value ?? 'All');
                              if (customerStore.searchedText.isEmpty &&
                                  customerStore.selectedUserType
                                          .toLowerCase() ==
                                      'all') {
                                customerStore.setIsFilterApplied(false);
                              } else {
                                customerStore.setIsFilterApplied(true);
                              }
                            },
                            items: const [
                              'All',
                              'Company',
                              'Broker',
                            ],
                          ),
                          SizedBox(
                            width: 8.dp,
                          ),
                          SizedBox(
                            width: 300.dp,
                            child: CustomSearchBar(
                              controller: customerStore.searchController,
                              onChanged: (final value) {
                                customerStore.setSearchText(value);
                                if (customerStore.searchedText.isEmpty &&
                                    customerStore.selectedUserType
                                            .toLowerCase() ==
                                        'all') {
                                  customerStore.setIsFilterApplied(false);
                                } else {
                                  customerStore.setIsFilterApplied(true);
                                }
                              },
                              hintText:
                                  'Search By Name, SSN Number, GST Number',
                            ),
                          ),
                          const Spacer(),
                          CustomImageButton(
                            imagePath: 'assets/icons/pdf_icon.png',
                            text: 'PDF',
                            borderColor: const Color(0xffE5E7EB),
                            buttonColor: Colors.white,
                            onClicked: () {},
                            // onClicked: widget.onExportPDF,
                          ),
                          SizedBox(
                            width: 12.dp,
                          ),
                          CustomImageButton(
                            imagePath: 'assets/icons/excel_icon.png',
                            text: 'Excel',
                            borderColor: const Color(0xffE5E7EB),
                            buttonColor: Colors.white,
                            onClicked: () {},
                            // onClicked: widget.onExportPDF,
                          ),
                          SizedBox(
                            width: 12.dp,
                          ),
                          Container(
                            height: 30.dp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: customerStore.isFilterApplied
                                      ? Colors.red
                                      : Colors.grey,
                                )),
                            child: IconButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              icon: Image.asset(
                                'assets/icons/cross_icon.png',
                                color: customerStore.isFilterApplied
                                    ? Colors.red
                                    : Colors.grey,
                                width: 30.dp,
                                height: 30.dp,
                              ),
                              tooltip: 'Clear All Filters',
                              onPressed: customerStore.clearAllFilters,
                              // onPressed: _clearAllFilters,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(
                    height: 24.dp,
                  ),
                  Observer(builder: (context) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.dp),
                              border: Border.all(
                                color: const Color(0xFFE5E7EB),
                                width: 1.5.dp,
                              ),
                            ),
                            child: DataTable(
                              dividerThickness: 0.1.dp,
                              headingRowHeight: 48,
                              dataRowMinHeight: 48,
                              headingRowColor: WidgetStateProperty.all(
                                  const Color(0xFFF9FAFB)),
                              dataRowColor: WidgetStateProperty.resolveWith(
                                  (states) => Colors.white),
                              showBottomBorder: false,
                              columns: columns.map((col) {
                                return DataColumn(
                                  label: InkWell(
                                    onTap: col.isSortable
                                        ? () =>
                                            customerStore.setSortKey(col.key)
                                        : null,
                                    child: Row(
                                      children: [
                                        Text(
                                          col.label,
                                          style: TextStyle(
                                            fontSize: 16.dp,
                                            color: const Color(
                                              0xFF4B5563,
                                            ),
                                          ),
                                        ),
                                        if (col.isSortable &&
                                            customerStore.sortKey == col.key)
                                          Icon(
                                            customerStore.sortAsc
                                                ? Icons.arrow_upward
                                                : Icons.arrow_downward,
                                            size: 14.dp,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              rows: customerStore.paginatedData.map((row) {
                                return DataRow(
                                  cells: columns.map((col) {
                                    if (col.isAction) {
                                      return DataCell(Row(
                                        children: [
                                          IconButton(
                                            icon: Image.asset(
                                              'assets/icons/edit_icon.png',
                                            ),
                                            onPressed: () =>
                                                _openForm(context, row),
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                              'assets/icons/delete_icon.png',
                                            ),
                                            onPressed: () =>
                                                _onDelete(context, row),
                                          ),
                                        ],
                                      ));
                                    }
                                    return DataCell(
                                      InkWell(
                                        onTap: () {
                                          customerStore
                                              .setSelectedCustomer(row);
                                          customerStore.toggleFilter();
                                        },
                                        child: Text(
                                          _getCellValue(row, col.key),
                                          style: TextStyle(
                                            fontSize: 14.dp,
                                            color: const Color(0xFF111827),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: customerStore.currentTablePage > 0
                              ? () => customerStore.setCurrentPageIndex(
                                  customerStore.currentTablePage - 1)
                              : null,
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text(
                            'Page ${customerStore.currentTablePage + 1} of ${customerStore.totalPages}'),
                        IconButton(
                          onPressed: customerStore.currentTablePage <
                                  customerStore.totalPages - 1
                              ? () => customerStore.setCurrentPageIndex(
                                  customerStore.currentTablePage + 1)
                              : null,
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            )
          : ShowUserInfoScreen(customer: customerStore.selectedCustomer!);
    });
  }

  String _getCellValue(CustomerModel row, String key) {
    switch (key) {
      case 'id':
        return row.id?.toString() ?? '';
      case 'name':
        return row.custName;
      case 'userType':
        return row.usertype.name;
      case 'gst':
        return row.gstNumber;
      case 'mobile':
        return row.mobileNumber;
      case 'address':
        return row.address ?? '-';
      default:
        return '';
    }
  }

  void _openForm(BuildContext context, [CustomerModel? customer]) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(customer == null ? 'Add User' : 'Edit User'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.dp),
          ),
          content: SizedBox(
            width: 500.dp, // Adjust as needed
            child: CustomerForm(
              existingCustomer: customer,
              onSubmit: (customerData) {
                if (customer?.id != null) {
                  customerStore.updateCustomer(customer!.id!, customerData);
                } else {
                  customerStore.addCustomer(customerData);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'User ${customerData.custName} ${customer?.id != null ? 'updated' : 'added'}')),
                );
                Navigator.pop(context); // Close dialog
              },
            ),
          ),
        );
      },
    );
  }

  void _onDelete(BuildContext context, CustomerModel customer) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Delete User',
          style: TextStyle(
            fontSize: 20.dp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete this user?',
              style: TextStyle(
                fontSize: 14.dp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A4A4A),
              ),
            ),
            SizedBox(
              height: 32.dp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(ctx),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFF3F4F6,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.dp),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.dp,
                      horizontal: 16.dp,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14.dp,
                        fontWeight: FontWeight.w600,
                        color: const Color(
                          0xFF374151,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.dp,
                ),
                InkWell(
                  onTap: () {
                    customerStore.deleteCustomer(customer.id!);
                    Navigator.of(context).pop();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.dp),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 8.dp,
                      horizontal: 16.dp,
                    ),
                    child: Text(
                      'Yes, Delete',
                      style: TextStyle(
                        fontSize: 14.dp,
                        fontWeight: FontWeight.w700,
                        color: const Color(
                          0xFFFFFFFF,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TableColumn {
  final String label;
  final String key;
  final bool isSortable;
  final bool isAction;

  TableColumn({
    required this.label,
    required this.key,
    this.isSortable = false,
    this.isAction = false,
  });
}
