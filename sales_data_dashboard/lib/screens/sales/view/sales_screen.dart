import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/app_enum.dart';
import 'package:sales_data_dashboard/models/sales_model.dart';
import 'package:sales_data_dashboard/screens/dashboard/store/activity_store.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/sales/store/sales_screen_store.dart';
import 'package:sales_data_dashboard/widgets/common_dropdown.dart';
import 'package:sales_data_dashboard/widgets/custom_data_table.dart';
import 'package:sales_data_dashboard/widgets/custom_image_button.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

import '../../../models/firm_model.dart';
import '../../../widgets/normal_button.dart';
import 'sales_form_widget.dart';

final getIt = GetIt.instance;

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late SalesScreenStore salesScreenStore;
  late UserDataStore userDataStore;
  late DashboardStore activityStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<SalesScreenStore>()) {
      getIt.registerFactory<SalesScreenStore>(() => SalesScreenStore());
    }

    if (!getIt.isRegistered<UserDataStore>(
      instanceName: 'UserDataStore',
    )) {
      getIt.registerSingleton<UserDataStore>(UserDataStore(),
          instanceName: 'UserDataStore');
    }
    userDataStore = getIt<UserDataStore>(
      instanceName: 'UserDataStore',
    );

    if (!getIt.isRegistered<DashboardStore>()) {
      getIt.registerSingleton<DashboardStore>(DashboardStore(userDataStore));
    }

    salesScreenStore = getIt<SalesScreenStore>();

    activityStore = getIt<DashboardStore>();

    if (userDataStore.salesList.isEmpty) {
      salesScreenStore.fetchSales();
      userDataStore.setSalesList(salesScreenStore.sales);
    } else {
      salesScreenStore.setSalesList(userDataStore.salesList);
    }
    salesScreenStore.calculateTotalPages();
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Date', key: 'date', isSortable: true),
      TableColumn(label: 'Item Id', key: 'itemId', isSortable: true),
      TableColumn(label: 'Pcs/Size', key: 'size'),
      TableColumn(label: 'Carat', key: 'carat', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
      TableColumn(
        label: 'Firm',
        key: 'firmType',
      ),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(label: 'Due Days', key: 'dueDays', isSortable: true),
      TableColumn(
        label: 'Payment Status',
        key: 'paymentStatus',
      ),
      TableColumn(
        label: 'Payment Option',
        key: 'paymentOption',
      ),
      TableColumn(label: 'Description', key: 'description'),
      TableColumn(label: 'Actions', key: 'actions', isAction: true),
    ];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        children: [
          Observer(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sales Management',
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
                    text: 'Create New Entry',
                    onPressed: () => _openSalesForm(context),
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
              child: Row(
                children: [
                  IntrinsicWidth(
                    child: CommonDropdown(
                      label: 'Firm Type',
                      value: salesScreenStore.selectedFilterFirm,
                      onChanged: (p0) {
                        salesScreenStore.setSelectedFilterFirm(p0!);
                        salesScreenStore.isFiltersApplied();
                      },
                      options: [
                        Firm.sahajanand.name,
                        Firm.harikrishnaEnterprise.name
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.dp,
                  ),
                  IntrinsicWidth(
                    child: CommonDropdown(
                      label: 'Payment Status',
                      value: salesScreenStore.salectedStatus,
                      onChanged: (p0) {
                        salesScreenStore.setSelectedStatus(p0!);
                        salesScreenStore.isFiltersApplied();
                      },
                      options: [
                        PaymentStatusEnum.all.name,
                        PaymentStatusEnum.paid.name,
                        PaymentStatusEnum.unpaid.name,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.dp,
                  ),
                  SizedBox(
                    width: 300.dp,
                    child: CustomSearchBar(
                      controller: salesScreenStore.searchcontroller,
                      onChanged: (final value) {
                        salesScreenStore.setSearchText(value);
                        salesScreenStore.isFiltersApplied();
                        salesScreenStore.calculateTotalPages();
                      },
                      hintText: 'Search By Name, Mobile Number, GST Number',
                    ),
                  ),
                  const Spacer(),
                  // CustomImageButton(
                  //   imagePath: 'assets/icons/excel_icon.png',
                  //   text: 'Excel',
                  //   borderColor: const Color(0xffE5E7EB),
                  //   buttonColor: Colors.white,
                  //   onClicked: () {},
                  //   // onClicked: widget.onExportPDF,
                  // ),
                  // SizedBox(
                  //   width: 12.dp,
                  // ),
                  Container(
                    height: 30.dp,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: salesScreenStore.isFilterApplied
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
                        color: salesScreenStore.isFilterApplied
                            ? Colors.red
                            : Colors.grey,
                        width: 30.dp,
                        height: 30.dp,
                      ),
                      tooltip: 'Clear All Filters',
                      onPressed: salesScreenStore.clearAllFilters,
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 12.dp),
          Observer(builder: (context) {
            return Expanded(
              child: salesScreenStore.sales.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/no_data_found.png',
                            width: 200.dp,
                            height: 200.dp,
                          ),
                          SizedBox(
                            height: 12.dp,
                          ),
                          Text(
                            'No Data Found',
                            style: TextStyle(
                                fontSize: 16.dp,
                                color: const Color(0xFF111827)),
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
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
                                          salesScreenStore.setSortKey(col.key)
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
                                          salesScreenStore.sortKey == col.key)
                                        Icon(
                                          salesScreenStore.sortAsc
                                              ? Icons.arrow_upward
                                              : Icons.arrow_downward,
                                          size: 14.dp,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            rows: salesScreenStore.paginatedData.map((row) {
                              return DataRow(
                                cells: columns.map((col) {
                                  if (col.isAction) {
                                    return DataCell(Row(
                                      children: [
                                        IconButton(
                                          icon: Image.asset(
                                            'assets/icons/edit_icon.png',
                                          ),
                                          onPressed: () {
                                            _openSalesForm(context, row);
                                          },
                                          // _openForm(context, row),
                                        ),
                                        IconButton(
                                          icon: Image.asset(
                                            'assets/icons/delete_icon.png',
                                          ),
                                          onPressed: () {
                                            _confirmDelete(context, row);
                                          },
                                        ),
                                      ],
                                    ));
                                  }
                                  return DataCell(
                                    Text(
                                      _getCellValue(row, col.key),
                                      style: TextStyle(
                                        fontSize: 14.dp,
                                        color: const Color(0xFF111827),
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
          Observer(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: salesScreenStore.currentTablePage > 0
                      ? () => salesScreenStore.setCurrentPageIndex(
                          salesScreenStore.currentTablePage - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                    'Page ${salesScreenStore.currentTablePage + 1} of ${salesScreenStore.totalPages}'),
                IconButton(
                  onPressed: salesScreenStore.currentTablePage <
                          salesScreenStore.totalPages - 1
                      ? () => salesScreenStore.setCurrentPageIndex(
                          salesScreenStore.currentTablePage + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  void _openSalesForm(BuildContext context, [Sale? existingSale]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        // scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          existingSale != null ? 'Edit Sales' : 'Create Sales',
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w600,
            color: const Color(
              0xFF111827,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: SalesFormWidget(
            salesScreenStore: salesScreenStore,
            existingSale: existingSale,
            partyList: userDataStore.partiesList,
            stockItemList: userDataStore.stockList,
            activityStore: activityStore,
            userDataStore: userDataStore,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Sale sale) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Delete Sales Data',
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
              'Are you sure you want to delete Sale data for ${sale.id}?',
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
                    salesScreenStore.deleteSale(sale.id).then((final onValue) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Sales data for ${sale.id} deleted')),
                      );
                    }).onError(
                      (error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Something went wrong while deleting Sales data: ${salesScreenStore.errorMessage}')),
                        );
                      },
                    );
                    setState(() {});
                    Navigator.pop(ctx);
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

  String _getCellValue(Sale row, String key) {
    switch (key) {
      case 'date':
        return row.createdAt.toIso8601String();
      case 'itemId':
        return row.stockDetails.itemId;
      case 'size':
        return row.stockDetails.size;
      case 'carat':
        return row.stockDetails.carat.toString();
      case 'rate':
        return row.stockDetails.rate.toString();
      case 'amount':
        return row.stockDetails.amount.toString();
      case 'firmType':
        return row.firm.name;
      case 'description':
        return row.description ?? '';
      case 'dueDays':
        return row.dueDays.toString();
      case 'paymentOption':
        return row.paymentOption.toString();
      case 'paymentStatus':
        return row.paymentStatus.toString();
      default:
        return '';
    }
  }
}
