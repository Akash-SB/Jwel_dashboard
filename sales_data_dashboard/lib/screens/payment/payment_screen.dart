import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/payment_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/payment/payment_form_widget.dart';
import 'package:sales_data_dashboard/screens/payment/store/payment_screen_store.dart';
import 'package:sales_data_dashboard/widgets/common_dropdown.dart';
import 'package:sales_data_dashboard/widgets/custom_data_table.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';
import 'package:sales_data_dashboard/widgets/normal_button.dart';

import '../../models/app_enum.dart';

final getIt = GetIt.instance;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentScreenStore paymentStore;
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

    if (!getIt.isRegistered<PaymentScreenStore>()) {
      getIt.registerFactory<PaymentScreenStore>(() => PaymentScreenStore());
    }
    paymentStore = getIt<PaymentScreenStore>();

    if (userDataStore.paymentList.isEmpty) {
      paymentStore.fetchPayments().then((final _) {
        userDataStore.setPaymentList(paymentStore.paymentList);
      });
    } else {
      paymentStore.setPaymentList(userDataStore.paymentList);
    }
    paymentStore.calculateTotalPages();
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Date', key: 'date', isSortable: true),
      TableColumn(label: 'Payment Id', key: 'id', isSortable: true),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(label: 'Item ID', key: 'itemId', isSortable: true),
      TableColumn(label: 'Party', key: 'party', isSortable: true),
      TableColumn(label: 'Payment type', key: 'paymentType', isSortable: true),
      TableColumn(
          label: 'Payment Nature', key: 'paymentNature', isSortable: true),
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
                  'Payment Management',
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
                    onPressed: () => _openPaymentForm(context),
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
                      label: 'Payment Status',
                      value: paymentStore.selectedStatus,
                      onChanged: (p0) {
                        paymentStore.setSelectedStatus(p0!);
                        paymentStore.isFiltersApplied();
                      },
                      options: [
                        'All',
                        PaymentNature.credit.name,
                        PaymentNature.debit.name,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.dp,
                  ),
                  SizedBox(
                    width: 300.dp,
                    child: CustomSearchBar(
                      controller: paymentStore.searchController,
                      onChanged: (final value) {
                        paymentStore.setSearchText(value);
                        paymentStore.isFiltersApplied();
                        paymentStore.calculateTotalPages();
                      },
                      hintText: 'Search By Name, Mobile Number, GST Number',
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 30.dp,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: paymentStore.isFilterApplied
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
                        color: paymentStore.isFilterApplied
                            ? Colors.red
                            : Colors.grey,
                        width: 30.dp,
                        height: 30.dp,
                      ),
                      tooltip: 'Clear All Filters',
                      onPressed: paymentStore.clearAllFilters,
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 12.dp),
          Expanded(
            child: Observer(builder: (context) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      final controller = horizontalScrollController;
                      controller.animateTo(
                        (controller.offset - 200)
                            .clamp(0.0, controller.position.maxScrollExtent),
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
                  Expanded(
                    child: paymentStore.paymentList.isEmpty
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
                                            ? () =>
                                                paymentStore.setSortKey(col.key)
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
                                                paymentStore.sortKey == col.key)
                                              Icon(
                                                paymentStore.sortAsc
                                                    ? Icons.arrow_upward
                                                    : Icons.arrow_downward,
                                                size: 14.dp,
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  rows: paymentStore.paginatedData.map((row) {
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
                                                  _openPaymentForm(
                                                      context, row);
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
                  ),
                  SizedBox(
                    width: 8.dp,
                  ),
                  InkWell(
                    onTap: () {
                      final controller = horizontalScrollController;
                      controller.animateTo(
                        (controller.offset + 200)
                            .clamp(0.0, controller.position.maxScrollExtent),
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
              );
            }),
          ),
          Observer(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: paymentStore.currentTablePage > 0
                      ? () => paymentStore.setCurrentPageIndex(
                          paymentStore.currentTablePage - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                    'Page ${paymentStore.currentTablePage + 1} of ${paymentStore.totalPages}'),
                IconButton(
                  onPressed: paymentStore.currentTablePage <
                          paymentStore.totalPages - 1
                      ? () => paymentStore.setCurrentPageIndex(
                          paymentStore.currentTablePage + 1)
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

  void _openPaymentForm(BuildContext context, [PaymentModel? existingPayment]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        // scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              existingPayment != null ? 'Edit Payment' : 'Create Payment',
              style: TextStyle(
                fontSize: 24.dp,
                fontWeight: FontWeight.w600,
                color: const Color(
                  0xFF111827,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.of(context, rootNavigator: true).pop(),
              child: Icon(
                Icons.close,
                size: 24.dp,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: PaymentFormWidget(
            existingPayment: existingPayment,
            partyList: userDataStore.partiesList,
            stockItemList: userDataStore.stockList,
            userDataStore: userDataStore,
            paymentScreenStore: paymentStore,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, PaymentModel payment) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Delete Payment Data',
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
              'Are you sure you want to delete Payment data for ${payment.id}?',
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
                    paymentStore
                        .deletePayment(payment.id)
                        .then((final onValue) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Payment data for ${payment.id} deleted')),
                      );
                    }).onError(
                      (error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Something went wrong while deleting Payment data: ${paymentStore.errorMessage}')),
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
}

String _getCellValue(PaymentModel row, String key) {
  switch (key) {
    case 'date':
      return row.date != null ? DateFormat('dd-MM-yyyy').format(row.date!) : '';
    case 'itemId':
      return row.stockDetails.itemName;
    case 'party':
      return row.party.name;
    case 'amount':
      return row.amount.toStringAsFixed(2);
    case 'id':
      return row.id;
    case 'paymentType':
      return row.paymentType.name;
    case 'paymentNature':
      return row.paymentNature.name;
    default:
      return '';
  }
}
