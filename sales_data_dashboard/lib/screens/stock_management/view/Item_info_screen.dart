import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/stock_management/store/stock_mgmt_store.dart';
import 'package:sales_data_dashboard/widgets/custom_image_button.dart';

import '../../../models/app_enum.dart';
import '../../../models/purchase_model.dart';
import '../../../models/sales_model.dart';
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
      TableColumn(label: 'Date', key: 'date', isSortable: true),
      TableColumn(label: 'Item Id', key: 'itemId', isSortable: true),
      TableColumn(label: 'Pcs/Size', key: 'size'),
      TableColumn(label: 'Carat', key: 'carat', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
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
                    _infoTile('Iten ID',
                        stockStore.selectedStockItem?.value.itemId ?? 'N/A'),
                    _infoTile('Item Name',
                        stockStore.selectedStockItem?.value.itemName ?? 'N/A'),
                    _infoTile('HSN Code',
                        stockStore.selectedStockItem?.value.hsnCode ?? 'N/A'),
                    _infoTile('Size',
                        stockStore.selectedStockItem?.value.size ?? 'N/A'),
                  ]),
                  TableRow(children: [
                    SizedBox(height: 16.dp),
                    SizedBox(height: 16.dp),
                    SizedBox(height: 16.dp),
                    SizedBox(height: 16.dp),
                  ]),
                  TableRow(children: [
                    _infoTile(
                        'Rate',
                        stockStore.selectedStockItem?.value.rate.toString() ??
                            '0'),
                    _infoTile(
                        'Carat',
                        stockStore.selectedStockItem?.value.carat.toString() ??
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
                  ]),
                ],
              ),
            );
          }),
          SizedBox(height: 16.dp),
          Text(
            'Stock History',
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
                      value: stockStore.selectedFilterTransactionType.name,
                      onChanged: (p0) {
                        stockStore.setSelectedFilterTransactionType(
                          TransactionTypeEnum.values.firstWhere(
                            (e) => e.name == p0,
                          ),
                        );
                      },
                      options: [
                        TransactionTypeEnum.sell.name,
                        TransactionTypeEnum.purchase.name
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12.dp,
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
                ],
              ),
            );
          }),
          SizedBox(height: 8.dp),
          Observer(builder: (context) {
            final dataList = (stockStore.selectedFilterTransactionType ==
                    TransactionTypeEnum.sell)
                ? userDataStore.salesList
                    .where((sale) =>
                        sale.stockDetails.itemId.toLowerCase() ==
                        stockStore.selectedStockItem?.value.itemId
                            .toLowerCase())
                    .toList()
                : userDataStore.purchaseList
                    .where((purchase) =>
                        purchase.stockDetails.itemId.toLowerCase() ==
                        stockStore.selectedStockItem?.value.itemId
                            .toLowerCase())
                    .toList();

            return Expanded(
              child: dataList.isEmpty
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
                            rows: dataList.map((row) {
                              return DataRow(
                                cells: columns.map((col) {
                                  return DataCell(
                                    Text(
                                      getCellValue(
                                        col.key,
                                        stockStore.selectedFilterTransactionType ==
                                                TransactionTypeEnum.sell
                                            ? row as Sale
                                            : null,
                                        stockStore.selectedFilterTransactionType ==
                                                TransactionTypeEnum.purchase
                                            ? row as Purchase
                                            : null,
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
        ],
      ),
    );
  }

  String getCellValue(String key, [Sale? row, Purchase? purchaseRow]) {
    switch (key) {
      case 'date':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.createdAt.toIso8601String() ?? 'N/A'
            : purchaseRow?.createdAt.toIso8601String() ?? 'N/A';
      case 'itemId':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.stockDetails.itemId ?? 'N/A'
            : purchaseRow?.stockDetails.itemId ?? 'N/A';
      case 'size':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.stockDetails.size ?? 'N/A'
            : purchaseRow?.stockDetails.size ?? 'N/A';
      case 'carat':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.stockDetails.carat.toString() ?? 'N/A'
            : purchaseRow?.stockDetails.carat.toString() ?? 'N/A';
      case 'rate':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.stockDetails.rate.toString() ?? 'N/A'
            : purchaseRow?.stockDetails.rate.toString() ?? 'N/A';
      case 'amount':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.stockDetails.amount.toString() ?? 'N/A'
            : purchaseRow?.stockDetails.amount.toString() ?? 'N/A';
      case 'description':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.description ?? 'N/A'
            : purchaseRow?.description ?? 'N/A';
      case 'dueDays':
        return row?.dueDays.toString() ?? 'N/A';
      case 'paymentOption':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.paymentOption.toString() ?? 'N/A'
            : purchaseRow?.paymentOption.toString() ?? 'N/A';
      case 'paymentStatus':
        return stockStore.selectedFilterTransactionType ==
                TransactionTypeEnum.sell
            ? row?.paymentStatus.toString() ?? 'N/A'
            : purchaseRow?.paymentStatus.toString() ?? 'N/A';
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
