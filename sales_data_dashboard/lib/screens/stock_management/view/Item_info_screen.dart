import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/stock_party_ledger.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/stock_management/store/stock_mgmt_store.dart';
import '../../../models/app_enum.dart';
import '../../../widgets/common_dropdown.dart';
import '../../../widgets/custom_data_table.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({
    super.key,
    required this.stockStore,
    required this.userDataStore,
  });

  final StockStore stockStore;
  final UserDataStore userDataStore;

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Transaction ID', key: 'transId'),
      TableColumn(
        label: 'Transaction Date',
        key: 'transDate',
      ),
      TableColumn(
        label: 'Transaction Type',
        key: 'transType',
      ),
      TableColumn(
        label: 'Customer Id',
        key: 'custId',
      ),
      TableColumn(
        label: 'Customer Name',
        key: 'custName',
      ),
      TableColumn(
        label: 'Product Id',
        key: 'prodId',
      ),
      TableColumn(
        label: 'Product Quantity',
        key: 'quantity',
      ),
      TableColumn(
        label: 'Amount',
        key: 'amount',
      ),
      TableColumn(
        label: 'Due Days',
        key: 'dueDays',
      ),
      TableColumn(
        label: 'Agent Name',
        key: 'agentName',
      ),
      TableColumn(
        label: 'Brokerage',
        key: 'brokerage',
      ),
      TableColumn(
        label: 'Payment Status',
        key: 'paymentStatus',
      ),
      TableColumn(
        label: 'Payment Option',
        key: 'paymentOption',
      ),
      TableColumn(
        label: 'Firm',
        key: 'firm',
      ),
      TableColumn(label: 'Description', key: 'description'),
    ];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => stockStore.toggleItemInfo(false),
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.arrow_back_sharp,
                  ),
                ),
                SizedBox(
                  width: 16.dp,
                ),
                Text(
                  'Item Information',
                  style: TextStyle(
                    fontSize: 20.dp,
                    fontWeight: FontWeight.bold,
                    color: const Color(
                      0xFF111827,
                    ),
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: 16.dp,
          ),
          Observer(builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.dp),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12.dp),
              ),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                },
                children: [
                  TableRow(children: [
                    _infoTile('Item ID',
                        stockStore.selectedStockItem?.value.itemId ?? 'N/A'),
                    _infoTile('Item Name',
                        stockStore.selectedStockItem?.value.itemName ?? 'N/A'),
                    _infoTile('HSN Code',
                        stockStore.selectedStockItem?.value.hsnCode ?? 'N/A'),
                    _infoTile(
                        'Rate',
                        stockStore.selectedStockItem?.value.rate.toString() ??
                            '0'),
                  ]),
                  TableRow(children: [
                    SizedBox(height: 16.dp),
                    SizedBox(height: 16.dp),
                    SizedBox(height: 16.dp),
                    SizedBox(height: 16.dp),
                  ]),
                  TableRow(children: [
                    _infoTile(
                        'Quantity',
                        stockStore.selectedStockItem?.value.quantity
                                .toString() ??
                            '0'),
                    _infoTile(
                        'Amount',
                        stockStore.selectedStockItem?.value.amount.toString() ??
                            '0'),
                    _infoTile(
                        'Available Quantity',
                        stockStore.selectedStockItem?.value.availableQuantity
                                .toString() ??
                            '0'),
                    SizedBox(height: 16.dp),
                  ]),
                ],
              ),
            );
          }),
          SizedBox(height: 16.dp),
          Text(
            'Stock Ledger',
            style: TextStyle(
              fontSize: 18.dp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF111827),
            ),
          ),
          SizedBox(height: 24.dp),
          Observer(builder: (context) {
            return SizedBox(
              child: Row(
                children: [
                  IntrinsicWidth(
                    child: CommonDropdown(
                      label: 'Transaction Type',
                      value: stockStore.selectedTransType,
                      onChanged: (p0) {
                        stockStore.setSelectedTransType(p0!);
                        stockStore.isInfoFilterAppliedCheck();
                      },
                      options: [
                        TransType.all.name,
                        TransType.sale.name,
                        TransType.purchase.name,
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.dp,
                  ),
                  IntrinsicWidth(
                    child: CommonDropdown(
                      label: 'Payment Status',
                      value: stockStore.selectedTransStatus,
                      onChanged: (p0) {
                        stockStore.setSelectedTransStatus(p0!);
                        stockStore.isInfoFilterAppliedCheck();
                      },
                      options: [
                        PaymentStatusEnum.all.name,
                        PaymentStatusEnum.paid.name,
                        PaymentStatusEnum.unpaid.name,
                      ],
                    ),
                  ),
                  const Spacer(),
                  // CustomImageButton(
                  //   imagePath: 'assets/icons/excel_icon.png',
                  //   text: 'Excel',
                  //   borderColor: const Color(0xffE5E7EB),
                  //   buttonColor: Colors.white,
                  //   onClicked: () {},
                  // ),
                  // SizedBox(
                  //   width: 12.dp,
                  // ),
                  Observer(builder: (context) {
                    return Container(
                      height: 30.dp,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: stockStore.isInfoFilterApplied
                                ? Colors.red
                                : Colors.grey,
                          )),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        onPressed: stockStore.clearInfoFilter,
                        icon: Image.asset(
                          'assets/icons/cross_icon.png',
                          color: stockStore.isInfoFilterApplied
                              ? Colors.red
                              : Colors.grey,
                          width: 30.dp,
                          height: 30.dp,
                        ),
                        tooltip: 'Clear All Filters',
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
          SizedBox(height: 8.dp),
          Observer(builder: (context) {
            return Expanded(
              child: stockStore.ledgerList.isEmpty
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
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            rows: stockStore.paginatedInfoData.map((row) {
                              return DataRow(
                                cells: columns.map((col) {
                                  return DataCell(
                                    Text(
                                      getCellValue(
                                        col.key,
                                        row,
                                      ),
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
                  onPressed: stockStore.currentInfoTablePage > 0
                      ? () => stockStore.setCurrentInfoTablePage(
                          stockStore.currentInfoTablePage - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                    'Page ${stockStore.currentInfoTablePage + 1} of ${stockStore.totalinfoPages}'),
                IconButton(
                  onPressed: stockStore.currentInfoTablePage <
                          stockStore.totalinfoPages - 1
                      ? () => stockStore.setTotalinfoPages(
                          stockStore.currentInfoTablePage + 1)
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

  String getCellValue(String key, [StockPartyLedger? info]) {
    switch (key) {
      case 'transId':
        return info?.id ?? '';
      case 'transDate':
        return info?.createdAt.toIso8601String() ?? 'NA';
      case 'transType':
        return info?.transType ?? 'NA';
      case 'custId':
        return info?.customerId ?? 'N/A';
      case 'custName':
        return info?.customerName ?? 'N/A';
      case 'prodId':
        return info?.productId ?? 'N/A';
      case 'quantity':
        return info?.quantity ?? 'N/A';
      case 'amount':
        return info?.amount ?? 'N/A';
      case 'dueDays':
        return info?.dueDays.toString() ?? 'N/A';
      case 'agentName':
        return info?.agentName ?? 'N/A';
      case 'brokerage':
        return info?.brokerage ?? 'N/A';
      case 'paymentStatus':
        return info?.paymentStatus ?? 'N/A';
      case 'firm':
        return info?.firm ?? 'N/A';
      case 'description':
        return info?.description ?? 'N/A';
      default:
        return '';
    }
  }

  Widget _infoTile(String title, String value) {
    return SizedBox(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 4.dp),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
