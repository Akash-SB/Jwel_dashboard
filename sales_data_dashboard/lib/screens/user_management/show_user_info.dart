import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/models/customer_model.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/screens/invoice/store/invoice_store.dart';
import 'package:sales_data_dashboard/screens/user_management/users_screen.dart';
import 'package:sales_data_dashboard/widgets/custom_image_button.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';
import 'package:sales_data_dashboard/widgets/filter_dropdown_button.dart';

class ShowUserInfoScreen extends StatefulWidget {
  final CustomerModel customer;

  const ShowUserInfoScreen({super.key, required this.customer});

  @override
  State<ShowUserInfoScreen> createState() => _ShowUserInfoScreenState();
}

class _ShowUserInfoScreenState extends State<ShowUserInfoScreen> {
  late List<InvoiceModel> transactions;
  late InvoiceStore invoiceStore;

  @override
  void initState() {
    super.initState();
    if (!getIt.isRegistered<InvoiceStore>()) {
      getIt.registerSingleton<InvoiceStore>(InvoiceStore());
    }

    invoiceStore = getIt<InvoiceStore>();
    invoiceStore.initSearchController();
  }

  @override
  Widget build(BuildContext context) {
    final customer = widget.customer;
    final List<TableColumn> columns = [
      TableColumn(label: 'Invoice ID', key: 'id', isSortable: true),
      TableColumn(label: 'Date', key: 'date', isSortable: true),
      TableColumn(label: 'Carat', key: 'carat', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(label: 'Customer Name', key: 'customerName', isAction: true),
      TableColumn(
          label: 'Payment Status', key: 'paymentStatus', isAction: true),
      TableColumn(label: 'Payment Type', key: 'paymentType', isAction: true),
      TableColumn(label: 'Note', key: 'note', isAction: true),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Customer Information',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 20,
                    runSpacing: 12,
                    children: [
                      _infoTile('Customer Name', customer.custName),
                      _infoTile('Mobile Number', customer.mobileNumber),
                      _infoTile('GST Number', customer.gstNumber),
                      _infoTile('User Type', customer.usertype.name),
                      _infoTile('Address', customer.address ?? 'N/A'),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Observer(builder: (context) {
            return SizedBox(
              height: 40.dp,
              child: Row(
                children: [
                  FilterDropdownButton(
                    selectedValue: invoiceStore.selectedPaymentStatus,
                    onChanged: (final value) {
                      invoiceStore.setSelectedPaymentStatus(value ?? 'All');
                    },
                    items: const [
                      'All',
                      'Paid',
                      'Unpaid',
                    ],
                  ),
                  SizedBox(
                    width: 8.dp,
                  ),
                  SizedBox(
                    width: 300.dp,
                    child: CustomSearchBar(
                      controller: TextEditingController(),
                      onChanged: (final _) {
                        invoiceStore.setSearchQuery(_);
                      },
                      hintText: 'Search By Name, SSN Number, GST Number',
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
                          color: Colors.grey,
                        )),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      icon: Image.asset(
                        'assets/icons/cross_icon.png',
                        color: Colors.grey,
                        width: 30.dp,
                        height: 30.dp,
                      ),
                      tooltip: 'Clear All Filters',
                      onPressed: () {
                        invoiceStore.setSelectedPaymentStatus('All');
                        invoiceStore.ledgerController.clear();
                        invoiceStore.setSearchQuery('');
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
          Observer(builder: (context) {
            return Expanded(
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showBottomBorder: false,
                    headingRowColor: WidgetStateProperty.all(
                      const Color(0xffF8FAFC),
                    ),
                    columns: columns.map((col) {
                      return DataColumn(
                        label: InkWell(
                          onTap: col.isSortable
                              ? () => invoiceStore.setSortKey(col.key)
                              : null,
                          child: Row(
                            children: [
                              Text(col.label),
                              if (col.isSortable &&
                                  invoiceStore.sortKey == col.key)
                                Icon(
                                  invoiceStore.sortAsc
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 14.dp,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    rows: invoiceStore.paginatedData.map((row) {
                      return DataRow(
                        cells: columns.map((col) {
                          return DataCell(
                            Text(
                              _getFieldValue(row, col.key),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _getFieldValue(InvoiceModel item, String key) {
    switch (key) {
      case 'invoiceId':
        return item.invoiceId;
      case 'date':
        return item.date;
      case 'carat':
        return item.size;
      case 'rate':
        return item.rate;
      case 'amount':
        return item.amount;
      case 'custName':
        return item.custName;
      case 'transactionType':
        return item.transactionType.name;
      case 'custType':
        return item.custType.name;
      case 'paymentStatus':
        return item.paymentStatus.name;
      case 'paymentType':
        return item.paymentType?.name ?? '';
      case 'note':
        return item.note ?? 'NA';
      default:
        return '';
    }
  }

  Widget _infoTile(String title, String value) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
