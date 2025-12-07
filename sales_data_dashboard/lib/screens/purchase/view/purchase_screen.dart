import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/purchase_model.dart';
import 'package:sales_data_dashboard/screens/purchase/view/purchase_form_widget.dart';
import 'package:sales_data_dashboard/widgets/custom_data_table.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

import '../../../Utils/common_utils.dart';
import '../../../models/app_enum.dart';
import '../../../models/firm_model.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/normal_button.dart';
import '../../home/store/userdata_store.dart';
import '../store/purchase_screen_store.dart';

final getIt = GetIt.instance;

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  late PurchaseScreenStore purchaseScreenStore;
  late UserDataStore userDataStore;
  final ScrollController horizontalScrollController = ScrollController();

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
    if (!getIt.isRegistered<PurchaseScreenStore>()) {
      getIt.registerFactory<PurchaseScreenStore>(() => PurchaseScreenStore(
            userDataStore: userDataStore,
          ));
    }
    purchaseScreenStore = getIt<PurchaseScreenStore>();
    purchaseScreenStore.setPurchaseList(userDataStore.purchaseList);
    purchaseScreenStore.setStockList(userDataStore.stockList);
    purchaseScreenStore.setPartiesList(userDataStore.partiesList);
    purchaseScreenStore.setCurrentPageIndex(0);
    purchaseScreenStore.calculateTotalPages();
    purchaseScreenStore.getPartyIds();
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Date', key: 'date', isSortable: true),
      TableColumn(label: 'Item Id', key: 'itemId', isSortable: true),
      // TableColumn(label: 'Pcs/Size', key: 'size'),
      // TableColumn(label: 'Carat', key: 'carat', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
      TableColumn(label: 'Buy Quantity', key: 'buyQuantity', isSortable: true),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(label: 'Firm', key: 'firmType', isSortable: true),
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
    return Observer(builder: (context) {
      return purchaseScreenStore.showLoaders.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.white,
              padding: EdgeInsets.all(24.dp),
              child: Column(
                children: [
                  Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Purchase Management',
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
                            text: 'Create New Purchase',
                            onPressed: () => _openPurchaseForm(context),
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
                              value: purchaseScreenStore.selectedFilterFirm,
                              onChanged: (p0) {
                                purchaseScreenStore.setSelectedFilterFirm(p0!);
                                purchaseScreenStore.isFiltersApplied();
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
                              value: purchaseScreenStore.salectedStatus,
                              onChanged: (p0) {
                                purchaseScreenStore.setSelectedStatus(p0!);
                                purchaseScreenStore.isFiltersApplied();
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
                              controller: purchaseScreenStore.searchcontroller,
                              onChanged: (final value) {
                                purchaseScreenStore.setSearchText(value);
                                purchaseScreenStore.isFiltersApplied();
                                purchaseScreenStore.calculateTotalPages();
                              },
                              hintText:
                                  'Search By Name, Mobile Number, GST Number',
                            ),
                          ),
                          const Spacer(),
                          // CustomImageButton(
                          //   imagePath: 'assets/icons/pdf_icon.png',
                          //   text: 'PDF',
                          //   borderColor: const Color(0xffE5E7EB),
                          //   buttonColor: Colors.white,
                          //   onClicked: () {},
                          //   // onClicked: widget.onExportPDF,
                          // ),
                          // SizedBox(
                          //   width: 12.dp,
                          // ),
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
                                  color: purchaseScreenStore.isFilterApplied
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
                                color: purchaseScreenStore.isFilterApplied
                                    ? Colors.red
                                    : Colors.grey,
                                width: 30.dp,
                                height: 30.dp,
                              ),
                              tooltip: 'Clear All Filters',
                              onPressed: purchaseScreenStore.clearAllFilters,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 12.dp),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          final controller = horizontalScrollController;
                          controller.animateTo(
                            (controller.offset - 200).clamp(
                                0.0, controller.position.maxScrollExtent),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.dp),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_left),
                        ),
                      ),
                      SizedBox(
                        width: 8.dp,
                      ),
                      Observer(builder: (context) {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: horizontalScrollController,
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
                                            ? () => purchaseScreenStore
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
                                                purchaseScreenStore.sortKey ==
                                                    col.key)
                                              Icon(
                                                purchaseScreenStore.sortAsc
                                                    ? Icons.arrow_upward
                                                    : Icons.arrow_downward,
                                                size: 14.dp,
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  rows: purchaseScreenStore.paginatedData
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
                                                  _openPurchaseForm(
                                                      context, row);
                                                },
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
                      SizedBox(
                        width: 8.dp,
                      ),
                      InkWell(
                        onTap: () {
                          final controller = horizontalScrollController;
                          controller.animateTo(
                            (controller.offset + 200).clamp(
                                0.0, controller.position.maxScrollExtent),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.dp),
                          alignment: Alignment.centerRight,
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_right),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Observer(builder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: purchaseScreenStore.currentTablePage > 0
                              ? () => purchaseScreenStore.setCurrentPageIndex(
                                  purchaseScreenStore.currentTablePage - 1)
                              : null,
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text(
                            'Page ${purchaseScreenStore.currentTablePage + 1} of ${purchaseScreenStore.totalPages}'),
                        IconButton(
                          onPressed: purchaseScreenStore.currentTablePage <
                                  purchaseScreenStore.totalPages - 1
                              ? () => purchaseScreenStore.setCurrentPageIndex(
                                  purchaseScreenStore.currentTablePage + 1)
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

  void _openPurchaseForm(BuildContext context, [Purchase? existingPurchase]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        // scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          existingPurchase != null ? 'Edit Purchase' : 'Create Purchase',
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w600,
            color: const Color(
              0xFF111827,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: PurchaseFormWidget(
            purchaseStore: purchaseScreenStore,
            existingPurchase: existingPurchase,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Purchase purchase) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Delete Purchase Entry',
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
              'Are you sure you want to delete purchase entry with id  ${purchase.id}?',
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
                    purchaseScreenStore.setShowLoader(true);
                    purchaseScreenStore
                        .deletePurchase(purchase.id)
                        .then((final onValue) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Invoice ${purchase.id} deleted')),
                      );
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Error deleting invoice: ${purchaseScreenStore.errorMessage}')),
                      );
                    });
                    Navigator.pop(ctx);
                    purchaseScreenStore.setShowLoader(false);
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

  String _getCellValue(Purchase row, String key) {
    switch (key) {
      case 'date':
        return CommonUtils.formatDate(row.createdAt);
      case 'itemId':
        return row.stockDetails.itemId;
      case 'quantity':
        return row.stockDetails.quantity ?? ' ';
      case 'rate':
        return row.stockDetails.rate.toString();
      case 'amount':
        return row.stockDetails.amount.toString();
      case 'buyQuantity':
        return row.buyQuantity.toString();
      case 'firmType':
        return row.firm;
      case 'description':
        return row.description;
      case 'paymentOption':
        return row.paymentOption.toString();
      case 'paymentStatus':
        return row.paymentStatus.toString();
      default:
        return '';
    }
  }
}
