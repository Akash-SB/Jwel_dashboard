import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/purchase_model.dart';
import 'package:sales_data_dashboard/screens/purchase/view/purchase_form_widget.dart';
import 'package:sales_data_dashboard/widgets/custom_data_table.dart';
import 'package:sales_data_dashboard/widgets/custom_image_button.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Date', key: 'date', isSortable: true),
      TableColumn(label: 'Item Id', key: 'itemId', isSortable: true),
      TableColumn(label: 'Pcs/Size', key: 'size'),
      TableColumn(label: 'Carat', key: 'carat', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
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
                      value: Firm.sahajanand.name,
                      // partyDetailsStore.selectedFilterFirm,
                      onChanged: (p0) {
                        // partyDetailsStore.setSelectedFilterFirm(p0!);
                        // partyDetailsStore.isFiltersApplied();
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
                      value: 'All',
                      onChanged: (p0) {
                        // partyDetailsStore.setSelectedFilterPartyType(p0!);
                        // partyDetailsStore.isFiltersApplied();
                      },
                      options: [
                        'All',
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
                      controller: TextEditingController(),
                      // controller: partyDetailsStore.searchcontroller,
                      onChanged: (final value) {
                        // partyDetailsStore.setSearchText(value);
                        // partyDetailsStore.isFiltersApplied();
                        // partyDetailsStore.calculateTotalPages();
                      },
                      hintText: 'Search By Name, Mobile Number, GST Number',
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
                          color: false
                              // partyDetailsStore.isFilterApplied
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
                        color: false
                            // partyDetailsStore.isFilterApplied
                            ? Colors.red
                            : Colors.grey,
                        width: 30.dp,
                        height: 30.dp,
                      ),
                      tooltip: 'Clear All Filters', onPressed: () {},
                      // onPressed: partyDetailsStore.clearAllFilters,
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
                      headingRowColor:
                          WidgetStateProperty.all(const Color(0xFFF9FAFB)),
                      dataRowColor: WidgetStateProperty.resolveWith(
                          (states) => Colors.white),
                      showBottomBorder: false,
                      columns: columns.map((col) {
                        return DataColumn(
                          label: InkWell(
                            onTap: col.isSortable
                                ? () => purchaseScreenStore.setSortKey(col.key)
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
                                    purchaseScreenStore.sortKey == col.key)
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
                      rows: purchaseScreenStore.paginatedData.map((row) {
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
                                      _openPurchaseForm(context, row);
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
                    purchaseScreenStore
                        .deletePurchase(purchase.id)
                        .then((final onValue) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Invoice ${purchase.id} deleted')),
                      );
                    });

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

  String _getCellValue(Purchase row, String key) {
    switch (key) {
      case 'date':
        return row.createdAt.toIso8601String();
      case 'itemId':
        return row.stockDetails.itemId;
      case 'size':
        return row.stockDetails.size;
      case 'rate':
        return row.stockDetails.rate.toString();
      case 'amount':
        return row.stockDetails.amount.toString();
      case 'firmType':
        return row.firm;
      // == Firm.sahajanand
      // ? Firm.sahajanand.name
      // : Firm.harikrishnaEnterprise.name;
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
