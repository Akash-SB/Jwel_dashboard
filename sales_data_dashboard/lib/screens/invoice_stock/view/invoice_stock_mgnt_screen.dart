import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/invoice_stock_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/invoice_stock/store/invoice_stock_store.dart';
import 'package:sales_data_dashboard/screens/invoice_stock/view/invoice_stock_ledger_screen.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

import '../../../models/firm_model.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/custom_data_table.dart';
import '../../../widgets/custom_image_button.dart';

final getIt = GetIt.instance;

class InvoiceStockMgntScreen extends StatefulWidget {
  const InvoiceStockMgntScreen({super.key});

  @override
  State<InvoiceStockMgntScreen> createState() => _InvoiceStockMgntScreenState();
}

class _InvoiceStockMgntScreenState extends State<InvoiceStockMgntScreen> {
  late InvoiceStockStore invoiceStockStore;
  late UserDataStore userDataStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<InvoiceStockStore>()) {
      getIt.registerFactory<InvoiceStockStore>(() => InvoiceStockStore());
    }
    invoiceStockStore = getIt<InvoiceStockStore>();

    if (!getIt.isRegistered<UserDataStore>(
      instanceName: 'UserDataStore',
    )) {
      getIt.registerSingleton<UserDataStore>(UserDataStore(),
          instanceName: 'UserDataStore');
    }
    userDataStore = getIt<UserDataStore>(
      instanceName: 'UserDataStore',
    );

    if (userDataStore.stockItemList.isNotEmpty) {
      invoiceStockStore.setInvoiceStockList(userDataStore.stockItemList);
      invoiceStockStore.setLoading(false);
    } else {
      invoiceStockStore.fetchStockItems().then((_) {
        userDataStore.setInvoiceStockList(invoiceStockStore.stockList.toList());
      });
    }
  }

  final List<TableColumn> columns = [
    TableColumn(
      label: 'Item Id',
      key: 'itemId',
    ),
    TableColumn(
      label: 'Item Name',
      key: 'itemName',
    ),
    TableColumn(label: 'HSN Code', key: 'hsnCode'),
    TableColumn(label: 'Item Weight', key: 'itemWeight'),
    TableColumn(label: 'Rate', key: 'rate', isSortable: true),
    TableColumn(label: 'Amount', key: 'amount', isSortable: true),
    TableColumn(label: 'Firm', key: 'firm'),
  ];

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return invoiceStockStore.showItemInfo.value
          ? InvoiceStockLedgerScreen()
          : Container(
              color: Colors.white,
              padding: EdgeInsets.all(24.dp),
              child: invoiceStockStore.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Observer(builder: (context) {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Invoice Stock Management',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(
                                    0xFF111827,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
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
                                    label: 'Firm',
                                    value: invoiceStockStore.selectedFirm,
                                    onChanged: (p0) {
                                      invoiceStockStore.setSelectedFirm(p0!);
                                      invoiceStockStore.isFiltersApplied();
                                    },
                                    options: [
                                      Firm.sahajanand.name,
                                      Firm.harikrishnaEnterprise.name,
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 12.dp,
                                ),
                                SizedBox(
                                  width: 300.dp,
                                  child: CustomSearchBar(
                                    controller:
                                        invoiceStockStore.searchcontroller,
                                    onChanged: (final value) {
                                      invoiceStockStore.setSearchText(value);
                                      invoiceStockStore.isFiltersApplied();
                                      invoiceStockStore.calculateTotalPages();
                                    },
                                    hintText:
                                        'Search By Name, SSN Number, GST Number',
                                  ),
                                ),
                                const Spacer(),
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
                                        color: invoiceStockStore.isFilterApplied
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
                                      color: invoiceStockStore.isFilterApplied
                                          ? Colors.red
                                          : Colors.grey,
                                      width: 30.dp,
                                      height: 30.dp,
                                    ),
                                    tooltip: 'Clear All Filters',
                                    onPressed:
                                        invoiceStockStore.clearAllFilters,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 12.dp),
                        Observer(builder: (context) {
                          return Expanded(
                            child: invoiceStockStore.stockList.isEmpty
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
                                          borderRadius:
                                              BorderRadius.circular(8.dp),
                                          border: Border.all(
                                            color: const Color(0xFFE5E7EB),
                                            width: 1.5.dp,
                                          ),
                                        ),
                                        child: DataTable(
                                          dividerThickness: 0.1.dp,
                                          headingRowHeight: 48,
                                          dataRowMinHeight: 48,
                                          headingRowColor:
                                              WidgetStateProperty.all(
                                                  const Color(0xFFF9FAFB)),
                                          dataRowColor:
                                              WidgetStateProperty.resolveWith(
                                                  (states) => Colors.white),
                                          showBottomBorder: false,
                                          columns: columns.map((col) {
                                            return DataColumn(
                                              label: Row(
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
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          rows: invoiceStockStore.paginatedData
                                              .map((row) {
                                            return DataRow(
                                              cells: columns.map((col) {
                                                return DataCell(
                                                  Observer(builder: (context) {
                                                    return InkWell(
                                                      onTap: () {
                                                        invoiceStockStore
                                                            .setSelectedStockItem(
                                                                row);
                                                        invoiceStockStore
                                                            .toggleItemInfo(
                                                                true);
                                                        // invoiceStockStore
                                                        //     .calculateInfoTotalPages();
                                                      },
                                                      child: Text(
                                                        _getCellValue(
                                                            row, col.key),
                                                        style: TextStyle(
                                                          fontSize: 14.dp,
                                                          color: const Color(
                                                              0xFF111827),
                                                        ),
                                                      ),
                                                    );
                                                  }),
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
                                onPressed: invoiceStockStore.currentTablePage >
                                        0
                                    ? () =>
                                        invoiceStockStore.setCurrentPageIndex(
                                            invoiceStockStore.currentTablePage -
                                                1)
                                    : null,
                                icon: const Icon(Icons.chevron_left),
                              ),
                              Text(
                                  'Page ${invoiceStockStore.currentTablePage + 1} of ${invoiceStockStore.totalPages}'),
                              IconButton(
                                onPressed: invoiceStockStore.currentTablePage <
                                        invoiceStockStore.totalPages - 1
                                    ? () =>
                                        invoiceStockStore.setCurrentPageIndex(
                                            invoiceStockStore.currentTablePage +
                                                1)
                                    : null,
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
            );
    });
  }

  String _getCellValue(InvoiceStockModel row, String key) {
    switch (key) {
      case 'itemId':
        return row.itemId;
      case 'itemName':
        return row.itemName;
      case 'hsnCode':
        return row.hsdCode;
      case 'itemWeight':
        return row.itemWeight.toString();
      case 'rate':
        return row.rate.toString();
      case 'amount':
        return row.amount.toString();
      case 'firm':
        return row.firm == Firm.sahajanand.name
            ? Firm.sahajanand.name
            : Firm.harikrishnaEnterprise.name;
      case 'description':
        return row.description ?? 'NA';
      default:
        return '';
    }
  }
}
