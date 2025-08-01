import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/screens/stock_management/store/stock_mgmt_store.dart';

class ItemInfoScreen extends StatelessWidget {
  const ItemInfoScreen({
    super.key,
    required this.stockStore,
  });

  final StockStore stockStore;

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 8.dp),
          // Observer(builder: (context) {
          //   return Expanded(
          //     child: SingleChildScrollView(
          //       child: SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: DataTable(
          //           showBottomBorder: false,
          //           headingRowColor: WidgetStateProperty.all(
          //             const Color(0xffF8FAFC),
          //           ),
          //           columns: columns.map((col) {
          //             return DataColumn(
          //               label: InkWell(
          //                 onTap: col.isSortable
          //                     ? () => invoiceStore.setSortKey(col.key)
          //                     : null,
          //                 child: Row(
          //                   children: [
          //                     Text(col.label),
          //                     if (col.isSortable &&
          //                         invoiceStore.sortKey == col.key)
          //                       Icon(
          //                         invoiceStore.sortAsc
          //                             ? Icons.arrow_upward
          //                             : Icons.arrow_downward,
          //                         size: 14.dp,
          //                       ),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           }).toList(),
          //           rows: invoiceStore.paginatedData
          //               .where(
          //                   (data) => data.custName == widget.customer.custName)
          //               .map((row) {
          //             return DataRow(
          //               cells: columns.map((col) {
          //                 return DataCell(
          //                   Text(
          //                     _getFieldValue(row, col.key),
          //                   ),
          //                 );
          //               }).toList(),
          //             );
          //           }).toList(),
          //         ),
          //       ),
          //     ),
          //   );
          // }),
        ],
      ),
    );
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
