import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/sales_model.dart';
import 'package:sales_data_dashboard/screens/sales/store/sales_screen_store.dart';

import '../../../widgets/normal_button.dart';
import '../../products/view/products_screen.dart';

final getIt = GetIt.instance;

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late SalesScreenStore salesScreenStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<SalesScreenStore>()) {
      getIt.registerFactory<SalesScreenStore>(() => SalesScreenStore());
    }
    salesScreenStore = getIt<SalesScreenStore>();
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
    return Column(
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
                  text: 'Create New Entry', onPressed: () {},
                  //  _openForm(context),
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
                              ? () => salesScreenStore.setSortKey(col.key)
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
                                  onPressed: () {},
                                  // _openForm(context, row),
                                ),
                                IconButton(
                                  icon: Image.asset(
                                    'assets/icons/delete_icon.png',
                                  ),
                                  onPressed: () {},
                                  // _confirmDelete(context, row),
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
    );
  }

  String _getCellValue(Sale row, String key) {
    switch (key) {
      case 'date':
        return row.createdAt.toIso8601String();
      case 'itemId':
        return row.itemId;
      case 'size':
        return row.size;
      case 'rate':
        return row.rate.toString();
      case 'amount':
        return row.amount.toString();
      case 'description':
        return row.description ?? '';
      case 'dueDays':
        return row.dueDays.toString();
      case 'paymentOption':
        return row.paymentOption.toString() ?? 'NA';
      case 'paymentStatus':
        return row.paymentStatus.toString();
      default:
        return '';
    }
  }
}
