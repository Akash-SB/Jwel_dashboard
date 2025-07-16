import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/Utils/generate_invoice.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import 'package:sales_data_dashboard/screens/invoice/store/invoice_store.dart';
import '../../widgets/custom_image_button.dart';
import '../../widgets/custom_searchbar.dart';
import '../../widgets/filter_dropdown_button.dart';
import '../../widgets/invoice_form_widget.dart';
import '../../widgets/normal_button.dart';
import '../products/view/products_screen.dart';

final getIt = GetIt.instance;

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late InvoiceStore invoiceStore;
  late UserDataStore userDataStore;

  @override
  void initState() {
    if (!getIt.isRegistered<InvoiceStore>()) {
      getIt.registerSingleton<InvoiceStore>(InvoiceStore());
    }

    if (!GetIt.I.isRegistered<UserDataStore>()) {
      GetIt.I.registerSingleton<UserDataStore>(UserDataStore());
    }
    userDataStore = GetIt.I<UserDataStore>();

    invoiceStore = getIt<InvoiceStore>();

    if (userDataStore.invoices.isEmpty) {
      invoiceStore.fetchInvoices();
      userDataStore.setInvoices(invoiceStore.invoices);
    } else {
      invoiceStore.setInvoices(userDataStore.invoices);
    }
    invoiceStore.initSearchController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<TableColumn> columns = [
      TableColumn(label: 'Invoice ID', key: 'invoiceId', isSortable: true),
      TableColumn(label: 'Date', key: 'date', isSortable: true),
      TableColumn(label: 'Product Name', key: 'productName', isSortable: true),
      TableColumn(label: 'Size', key: 'size', isSortable: true),
      TableColumn(label: 'Rate', key: 'rate', isSortable: true),
      TableColumn(label: 'Amount', key: 'amount', isSortable: true),
      TableColumn(label: 'Customer Name', key: 'custName'),
      TableColumn(
        label: 'Days of Interest',
        key: 'interestDays',
      ),
      TableColumn(label: 'Customer Type', key: 'custType'),
      TableColumn(label: 'Transaction Type', key: 'transactionType'),
      TableColumn(label: 'Payment Status', key: 'paymentStatus'),
      TableColumn(label: 'Payment Type', key: 'paymentType'),
      TableColumn(label: 'Note', key: 'note'),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Invoice Management',
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
                    text: 'Create New Invoice',
                    onPressed: () => _openInvoiceForm(context),
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
              height: 40.dp,
              child: Row(
                children: [
                  FilterDropdownButton(
                    selectedValue: invoiceStore.selectedPaymentStatus,
                    onChanged: (final value) {
                      invoiceStore.setSelectedPaymentStatus(value ?? 'All');
                      invoiceStore.isFiltersApplied();
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
                  FilterDropdownButton(
                    selectedValue: invoiceStore.selectedPaymentType,
                    onChanged: (final value) {
                      invoiceStore.setselectedPaymentTYpe(value ?? 'All');
                      invoiceStore.isFiltersApplied();
                    },
                    items: const ['All', 'Cash', 'Cheque', 'Online'],
                  ),
                  SizedBox(
                    width: 8.dp,
                  ),
                  SizedBox(
                    width: 300.dp,
                    child: CustomSearchBar(
                      controller: invoiceStore.ledgerController,
                      onChanged: (final value) {
                        invoiceStore.setSearchQuery(value);
                        invoiceStore.isFiltersApplied();
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
                    onClicked: () {
                      invoiceStore.exportPDF();
                    },
                  ),
                  SizedBox(
                    width: 12.dp,
                  ),
                  CustomImageButton(
                    imagePath: 'assets/icons/excel_icon.png',
                    text: 'Excel',
                    borderColor: const Color(0xffE5E7EB),
                    buttonColor: Colors.white,
                    onClicked: () {
                      invoiceStore.exportExcel();
                    },
                  ),
                  SizedBox(
                    width: 12.dp,
                  ),
                  Container(
                    height: 30.dp,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: invoiceStore.isFilterApplied
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
                        color: invoiceStore.isFilterApplied
                            ? Colors.red
                            : Colors.grey,
                        width: 30.dp,
                        height: 30.dp,
                      ),
                      tooltip: 'Clear All Filters',
                      onPressed: invoiceStore.clearFilters,
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: 24.dp,
          ),
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
                                ? () => invoiceStore.setSortKey(col.key)
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
                            if (col.isAction) {
                              return DataCell(Row(
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/icons/edit_icon.png',
                                    ),
                                    onPressed: () =>
                                        _openInvoiceForm(context, row),
                                    // onPressed: () => _openForm(context, row),
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/icons/delete_icon.png',
                                    ),
                                    onPressed: () =>
                                        _confirmDelete(context, row),
                                  ),
                                ],
                              ));
                            }
                            return DataCell(
                              InkWell(
                                onTap: () async {
                                  final companies = [
                                    CompanyModel(
                                      name: 'ABC Jewellers Pvt Ltd',
                                      gstin: '27ABCDE1234F1Z5',
                                      address: '123 Business Street, Mumbai',
                                      phone: '+91-9999999999',
                                    ),
                                    CompanyModel(
                                      name: 'XYZ Gold Traders',
                                      gstin: '27XYZ9876F1Z5',
                                      address: '45 Market Road, Pune',
                                      phone: '+91-8888888888',
                                    ),
                                  ];
                                  final selected = await showCompanyPicker(
                                      context, companies);
                                  if (selected != null) {
                                    showInvoicePreview(context, row, selected);
                                  }
                                },
                                child: Text(
                                  invoiceStore.getFieldValue(row, col.key),
                                  style: TextStyle(
                                    fontSize: 14.dp,
                                    color: const Color(0xFF111827),
                                  ),
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
          const SizedBox(height: 10),
          Observer(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: invoiceStore.currentTablePage > 0
                      ? () => invoiceStore.setCurrentPageIndex(
                          invoiceStore.currentTablePage - 1)
                      : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                    'Page ${invoiceStore.currentTablePage + 1} of ${invoiceStore.totalPages}'),
                IconButton(
                  onPressed: invoiceStore.currentTablePage <
                          invoiceStore.totalPages - 1
                      ? () => invoiceStore.setCurrentPageIndex(
                          invoiceStore.currentTablePage + 1)
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

  void _openInvoiceForm(BuildContext context, [InvoiceModel? existingInvoice]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        // scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          existingInvoice != null ? 'Edit Invoice' : 'Create Invoice',
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w600,
            color: const Color(
              0xFF111827,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: InvoiceForm(
            existingInvoice: existingInvoice,
            onSubmit: (invoiceData) {
              invoiceStore.addInvoice(invoiceData);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Invoice ${invoiceData.invoiceId} added')),
              );
              Navigator.pop(context); // Close bottom sheet
            },
            customers: userDataStore.customers,
            products: userDataStore.products,
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, InvoiceModel invoice) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.dp),
        ),
        title: Text(
          'Delete Invoice',
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
              'Are you sure you want to delete invoice ${invoice.invoiceId}?',
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
                    invoiceStore.deleteInvoice(invoice.invoiceId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Invoice ${invoice.invoiceId} deleted')),
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

class CompanyModel {
  final String name;
  final String gstin;
  final String address;
  final String phone;

  CompanyModel({
    required this.name,
    required this.gstin,
    required this.address,
    required this.phone,
  });
}
