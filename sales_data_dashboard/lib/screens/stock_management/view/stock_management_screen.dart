import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/stock_item.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/widgets/common_dropdown.dart';

import '../../../widgets/custom_image_button.dart';
import '../../../widgets/custom_searchbar.dart';
import '../../../widgets/normal_button.dart';
import '../../products/view/products_screen.dart';
import '../store/stock_mgmt_store.dart';
import 'Item_info_screen.dart';
import 'stock_form_widget.dart';

final getIt = GetIt.instance;

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({super.key});

  @override
  State<StockManagementScreen> createState() =>
      _StockManagementScreenScreenState();
}

class _StockManagementScreenScreenState extends State<StockManagementScreen> {
  late StockStore stockStore;
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
    if (!getIt.isRegistered<StockStore>()) {
      getIt.registerFactory<StockStore>(
          () => StockStore(userDataStore: userDataStore));
    }
    stockStore = getIt<StockStore>();
    stockStore.setStockItemList(userDataStore.stockList);
    stockStore.calculateTotalPages();
  }

  @override
  Widget build(BuildContext context) {
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
      TableColumn(label: 'Size', key: 'size'),
      TableColumn(label: 'Carat', key: 'carat', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
      TableColumn(
          label: 'Available Quantity', key: 'availableQuant', isSortable: true),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(label: 'Firm', key: 'firm'),
      TableColumn(label: 'Description', key: 'description'),
      TableColumn(label: 'Actions', key: 'actions', isAction: true),
    ];
    return Observer(builder: (context) {
      return stockStore.showItemInfo.value
          ? ItemInfoScreen(
              stockStore: stockStore,
              userDataStore: userDataStore,
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.all(24.dp),
              child: stockStore.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Observer(builder: (context) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Stock Management',
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
                                  text: 'Add Stock Item',
                                  onPressed: () => _openStockForm(context),
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
                                    value: stockStore.selectedFirm,
                                    onChanged: (p0) {
                                      stockStore.setSelectedFirm(p0!);
                                      stockStore.isFiltersApplied();
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
                                    controller: stockStore.searchcontroller,
                                    onChanged: (final value) {
                                      stockStore.setSearchText(value);
                                      stockStore.isFiltersApplied();
                                      stockStore.calculateTotalPages();
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
                                        color: stockStore.isFilterApplied
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
                                      color: stockStore.isFilterApplied
                                          ? Colors.red
                                          : Colors.grey,
                                      width: 30.dp,
                                      height: 30.dp,
                                    ),
                                    tooltip: 'Clear All Filters',
                                    onPressed: stockStore.clearAllFilters,
                                    // onPressed: _clearAllFilters,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 12.dp),
                        Observer(builder: (context) {
                          return Expanded(
                            child: stockStore.stockItemList.isEmpty
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
                                              label: InkWell(
                                                onTap: col.isSortable
                                                    ? () => stockStore
                                                        .setSortKey(col.key)
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
                                                        stockStore.sortKey ==
                                                            col.key)
                                                      Icon(
                                                        stockStore.sortAsc
                                                            ? Icons.arrow_upward
                                                            : Icons
                                                                .arrow_downward,
                                                        size: 14.dp,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          rows: stockStore.paginatedData
                                              .map((row) {
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
                                                          _openStockForm(
                                                              context, row);
                                                        },
                                                        // _openForm(context, row),
                                                      ),
                                                      IconButton(
                                                        icon: Image.asset(
                                                          'assets/icons/delete_icon.png',
                                                        ),
                                                        onPressed: () {
                                                          _confirmDelete(
                                                              context, row);
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                                }
                                                return DataCell(
                                                  Observer(builder: (context) {
                                                    return InkWell(
                                                      onTap: () {
                                                        stockStore
                                                            .setSelectedProduct(
                                                                row);
                                                        stockStore
                                                            .toggleItemInfo(
                                                                true);
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
                                onPressed: stockStore.currentTablePage > 0
                                    ? () => stockStore.setCurrentPageIndex(
                                        stockStore.currentTablePage - 1)
                                    : null,
                                icon: const Icon(Icons.chevron_left),
                              ),
                              Text(
                                  'Page ${stockStore.currentTablePage + 1} of ${stockStore.totalPages}'),
                              IconButton(
                                onPressed: stockStore.currentTablePage <
                                        stockStore.totalPages - 1
                                    ? () => stockStore.setCurrentPageIndex(
                                        stockStore.currentTablePage + 1)
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

  void _openStockForm(BuildContext context, [StockItem? existingStock]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        // scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          existingStock != null ? 'Edit Stock Item' : 'Create Stock Item',
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w600,
            color: const Color(
              0xFF111827,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: StockFormWidget(
            stockStore: stockStore,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, StockItem stock) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Delete Stock Item',
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
              'Are you sure you want to delete Stock Item ${stock.itemId}?',
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
                    stockStore
                        .deleteStockItem(stock.itemId)
                        .then((final onValue) {
                      // activityStore.addActivity(Activity(
                      //   id: invoice.invoiceId,
                      //   date: DateTime.parse(invoice.date),
                      //   title: 'Invoice data for ${invoice.custName} Deleted',
                      // ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Invoice ${stock.itemId} deleted')),
                      );
                    });

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

  String _getCellValue(StockItem row, String key) {
    switch (key) {
      case 'itemId':
        return row.itemId;
      case 'itemName':
        return row.itemName;
      case 'hsnCode':
        return row.hsnCode;
      case 'size':
        return row.size;
      case 'carat':
        return row.carat.toString();
      case 'rate':
        return row.rate.toString();
      case 'availableQuant':
        return row.availableQuantity.toString();
      case 'amount':
        return row.amount.toString();
      case 'firm':
        return row.firm == Firm.sahajanand.name
            ? Firm.sahajanand.name
            : Firm.harikrishnaEnterprise.name;
      case 'description':
        return row.description;
      default:
        return '';
    }
  }
}
