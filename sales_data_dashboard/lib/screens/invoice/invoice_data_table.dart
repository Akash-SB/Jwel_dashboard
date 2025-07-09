import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart' as excel;
import 'package:sales_data_dashboard/models/invoice_model.dart';
import '../../Utils/app_sizer.dart';
import '../../widgets/custom_image_button.dart';

// Sample enums
enum PaymentStatusEnum { paid, unpaid }

enum PaymentTypeEnum { cash, cheque, online }

class InvoiceDataTable extends StatefulWidget {
  final List<InvoiceModel> data;
  final void Function(InvoiceModel)? onEdit;
  final void Function(InvoiceModel)? onDelete;

  const InvoiceDataTable({
    super.key,
    required this.data,
    this.onEdit,
    this.onDelete,
    required Null Function() onExportPDF,
    required Null Function() onExportExcel,
  });

  @override
  State<InvoiceDataTable> createState() => _InvoiceDataTableState();
}

class _InvoiceDataTableState extends State<InvoiceDataTable> {
  String searchQuery = '';
  String selectedPaymentStatus = 'All';
  String selectedPaymentType = 'All';
  int currentPage = 0;
  int rowsPerPage = 5;
  String? sortKey;
  bool sortAsc = true;

  List<InvoiceModel> get filteredData {
    return widget.data.where((item) {
      final query = searchQuery.toLowerCase();
      final matchesSearch = item.invoiceId.toLowerCase().contains(query) ||
          item.custName.toLowerCase().contains(query);

      final paymentStatusStr =
          item.paymentStatus.toString().split('.').last.toLowerCase();
      final paymentTypeStr =
          (item.paymentType?.toString().split('.').last.toLowerCase()) ?? '';

      final matchesStatus = selectedPaymentStatus.toLowerCase() == 'all'
          ? true
          : paymentStatusStr == selectedPaymentStatus.toLowerCase();

      final matchesType = selectedPaymentType.toLowerCase() == 'all'
          ? true
          : paymentTypeStr == selectedPaymentType.toLowerCase();

      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  bool get _filtersApplied {
    return searchQuery.isNotEmpty ||
        selectedPaymentStatus.toLowerCase() != 'all' ||
        selectedPaymentType.toLowerCase() != 'all' ||
        sortKey != null;
  }

  List<InvoiceModel> get sortedData {
    final sorted = [...filteredData];
    if (sortKey != null) {
      sorted.sort((a, b) {
        final aValue = _getFieldValue(a, sortKey!);
        final bValue = _getFieldValue(b, sortKey!);
        return sortAsc ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });
    }
    return sorted;
  }

  String _getFieldValue(InvoiceModel item, String key) {
    switch (key) {
      case 'invoiceId':
        return item.invoiceId;
      case 'date':
        return item.date;
      case 'size':
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

  List<InvoiceModel> get paginatedData {
    final start = currentPage * rowsPerPage;
    final end = (start + rowsPerPage).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
  }

  void _onSort(String key) {
    setState(() {
      if (sortKey == key) {
        sortAsc = !sortAsc;
      } else {
        sortKey = key;
        sortAsc = true;
      }
    });
  }

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      selectedPaymentStatus = 'All';
      selectedPaymentType = 'All';
      currentPage = 0;
      sortKey = null;
      sortAsc = true;
    });
  }

  Future<void> _exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.TableHelper.fromTextArray(
            data: <List<String>>[
              <String>[
                'Invoice ID',
                'Date',
                'Carat',
                'Rate',
                'Amount',
                'Customer Name',
                'Transaction Type',
                'Customer Type',
                'Payment Status',
                'Payment Type',
                'Note',
              ],
              ...filteredData.map((item) => [
                    item.invoiceId,
                    item.date,
                    item.size,
                    item.rate,
                    item.amount,
                    item.custName,
                    item.transactionType.toString().split('.').last,
                    item.custType.toString().split('.').last,
                    item.paymentStatus.toString().split('.').last,
                    item.paymentType?.toString().split('.').last ?? '',
                    item.note ?? '',
                  ]),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  Future<void> _exportExcel() async {
    var excelFile = excel.Excel.createExcel();
    final sheet = excelFile['Sheet1'];

    final headers = [
      'Invoice ID',
      'Date',
      'Carat',
      'Rate',
      'Amount',
      'Customer Name',
      'Transaction Type',
      'Customer Type',
      'Payment Status',
      'Payment Type',
      'Note',
    ];

    sheet.appendRow(headers);

    for (var item in filteredData) {
      sheet.appendRow([
        item.invoiceId,
        item.date,
        item.size,
        item.rate,
        item.amount,
        item.custName,
        item.transactionType.toString().split('.').last,
        item.custType.toString().split('.').last,
        item.paymentStatus.toString().split('.').last,
        item.paymentType?.toString().split('.').last ?? '',
        item.note ?? '',
      ]);
    }

    final fileBytes = excelFile.encode();
    if (fileBytes == null) return;

    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/invoices_export.xlsx';
    final file = File(path);
    await file.writeAsBytes(fileBytes);
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (sortedData.length / rowsPerPage).ceil();

    return Column(
      children: [
        Row(
          children: [
            DropdownButton<String>(
              value: selectedPaymentStatus,
              items: ['All', 'Paid', 'Unpaid']
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedPaymentStatus = val!;
                  currentPage = 0;
                });
              },
              hint: const Text('Payment Status'),
            ),
            const SizedBox(width: 10),
            DropdownButton<String>(
              value: selectedPaymentType,
              items: ['All', 'Cash', 'Cheque', 'Online']
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedPaymentType = val!;
                  currentPage = 0;
                });
              },
              hint: const Text('Payment Type'),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 250,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (val) {
                  setState(() {
                    searchQuery = val;
                    currentPage = 0;
                  });
                },
              ),
            ),
            const Spacer(),
            Container(
              height: 30.dp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _filtersApplied ? Colors.red : Colors.grey,
                ),
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                padding: EdgeInsets.zero,
                icon: Icon(Icons.clear,
                    size: 20.dp,
                    color: _filtersApplied ? Colors.red : Colors.grey),
                tooltip: 'Clear All Filters',
                onPressed: _filtersApplied ? _clearFilters : null,
              ),
            ),
            const SizedBox(width: 8),
            CustomImageButton(
              imagePath: 'assets/icons/pdf_icon.png',
              text: 'PDF',
              onClicked: _exportPDF,
              borderColor: Colors.grey,
              buttonColor: Colors.white,
            ),
            SizedBox(width: 12.dp),
            CustomImageButton(
              imagePath: 'assets/icons/excel_icon.png',
              text: 'Excel',
              onClicked: _exportExcel,
              borderColor: Colors.grey,
              buttonColor: Colors.white,
            ),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(const Color(0xffF8FAFC)),
            columns: [
              _buildColumn('Invoice ID', 'invoiceId'),
              _buildColumn('Date', 'date'),
              _buildColumn('Carat', 'carat'),
              _buildColumn('Rate', 'rate'),
              _buildColumn('Amount', 'amount'),
              _buildColumn('Customer Name', 'custName'),
              _buildColumn('Transaction Type', 'transactionType'),
              _buildColumn('Customer Type', 'custType'),
              _buildColumn('Payment Status', 'paymentStatus'),
              _buildColumn('Payment Type', 'paymentType'),
              _buildColumn('Note', 'note'),
            ],
            rows: paginatedData
                .map((item) => DataRow(cells: [
                      DataCell(Text(item.invoiceId)),
                      DataCell(Text(item.date)),
                      DataCell(Text(item.size)),
                      DataCell(Text(item.rate)),
                      DataCell(Text(item.amount)),
                      DataCell(Text(item.custName)),
                      DataCell(Text(
                          item.transactionType.toString().split('.').last)),
                      DataCell(Text(item.custType.toString().split('.').last)),
                      DataCell(
                          Text(item.paymentStatus.toString().split('.').last)),
                      DataCell(Text(
                          item.paymentType?.toString().split('.').last ?? '')),
                      DataCell(Text(item.note ?? '-')),
                    ]))
                .toList(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed:
                  currentPage > 0 ? () => setState(() => currentPage--) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Text('Page ${currentPage + 1} of $totalPages'),
            IconButton(
              onPressed: currentPage < totalPages - 1
                  ? () => setState(() => currentPage++)
                  : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }

  DataColumn _buildColumn(String label, String key) {
    return DataColumn(
      label: InkWell(
        onTap: () => _onSort(key),
        child: Row(
          children: [
            Text(label),
            if (sortKey == key)
              Icon(sortAsc ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14.dp),
          ],
        ),
      ),
    );
  }
}
