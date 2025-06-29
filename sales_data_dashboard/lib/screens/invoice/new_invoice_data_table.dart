import 'package:excel/excel.dart' as excel; // add excel package
import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';
import 'package:sales_data_dashboard/widgets/custom_image_button.dart';
import 'package:sales_data_dashboard/widgets/custom_searchbar.dart';

import 'package:pdf/widgets.dart' as pw; // add pdf package
import 'package:printing/printing.dart'; // for printing/saving pdf

import 'dart:io'; // For File
import 'package:path_provider/path_provider.dart'; // To get temp dir

enum PaymentStatusEnum { all, paid, unpaid }

enum PaymentTypeEnum { all, cash, cheque, online }

class InvoiceDataTable extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int rowsPerPage;

  const InvoiceDataTable({
    super.key,
    required this.data,
    this.rowsPerPage = 5,
  });

  @override
  State<InvoiceDataTable> createState() => _InvoiceDataTableState();
}

class _InvoiceDataTableState extends State<InvoiceDataTable> {
  String searchQuery = '';
  PaymentStatusEnum selectedPaymentStatus = PaymentStatusEnum.all;
  PaymentTypeEnum selectedPaymentType = PaymentTypeEnum.all;
  int currentPage = 0;
  late int rowsPerPage;
  String? sortKey;
  bool sortAsc = true;

  @override
  void initState() {
    super.initState();
    rowsPerPage = widget.rowsPerPage;
  }

  bool get _filtersApplied {
    return searchQuery.isNotEmpty ||
        selectedPaymentStatus != PaymentStatusEnum.all ||
        selectedPaymentType != PaymentTypeEnum.all ||
        sortKey != null;
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
      selectedPaymentStatus = PaymentStatusEnum.all;
      selectedPaymentType = PaymentTypeEnum.all;
      currentPage = 0;
      sortKey = null;
      sortAsc = true;
    });
  }

  List<Map<String, dynamic>> get filteredData {
    return widget.data.where((item) {
      final query = searchQuery.toLowerCase();
      final matchesSearch =
          item['invoiceId'].toString().toLowerCase().contains(query) ||
              item['custName'].toString().toLowerCase().contains(query);

      final paymentStatusStr = item['paymentStatus'].toString().split('.').last;
      final paymentTypeStr =
          (item['paymentType']?.toString().split('.').last) ?? '';

      final matchesStatus = selectedPaymentStatus == PaymentStatusEnum.all ||
          paymentStatusStr.toLowerCase() ==
              selectedPaymentStatus.toString().split('.').last.toLowerCase();

      final matchesType = selectedPaymentType == PaymentTypeEnum.all ||
          paymentTypeStr.toLowerCase() ==
              selectedPaymentType.toString().split('.').last.toLowerCase();

      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  List<Map<String, dynamic>> get sortedData {
    List<Map<String, dynamic>> sorted = [...filteredData];
    if (sortKey != null) {
      sorted.sort((a, b) {
        final aVal = a[sortKey];
        final bVal = b[sortKey];

        // Try parsing date if sorting by date column
        if (sortKey == 'date') {
          final aDate = DateTime.tryParse(aVal.toString());
          final bDate = DateTime.tryParse(bVal.toString());
          if (aDate != null && bDate != null) {
            return sortAsc ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
          }
        }

        // Numeric comparison if possible
        final aNum = double.tryParse(aVal.toString());
        final bNum = double.tryParse(bVal.toString());
        if (aNum != null && bNum != null) {
          return sortAsc ? aNum.compareTo(bNum) : bNum.compareTo(aNum);
        }

        // Default string comparison
        return sortAsc
            ? aVal.toString().compareTo(bVal.toString())
            : bVal.toString().compareTo(aVal.toString());
      });
    }
    return sorted;
  }

  List<Map<String, dynamic>> get paginatedData {
    final start = currentPage * rowsPerPage;
    final end = (start + rowsPerPage).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
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
                    item['invoiceId'] ?? '',
                    item['date'] ?? '',
                    item['carat'] ?? '',
                    item['rate'] ?? '',
                    item['amount'] ?? '',
                    item['custName'] ?? '',
                    item['transactionType'].toString().split('.').last,
                    item['custType'].toString().split('.').last,
                    item['paymentStatus'].toString().split('.').last,
                    item['paymentType']?.toString().split('.').last ?? '',
                    item['note'] ?? '',
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
        item['invoiceId'] ?? '',
        item['date'] ?? '',
        item['carat'] ?? '',
        item['rate'] ?? '',
        item['amount'] ?? '',
        item['custName'] ?? '',
        item['transactionType'].toString().split('.').last,
        item['custType'].toString().split('.').last,
        item['paymentStatus'].toString().split('.').last,
        item['paymentType']?.toString().split('.').last ?? '',
        item['note'] ?? '',
      ]);
    }

    final fileBytes = excelFile.encode();
    if (fileBytes == null) return;

    // Save to temp directory & open it
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/invoices_export.xlsx';
    final file = File(path);
    await file.writeAsBytes(fileBytes);

    // You can open the file here or share it
    // For example: open_file package or share_plus
    // Open file example (add open_file package):
    // await OpenFile.open(path);
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (sortedData.length / rowsPerPage).ceil();

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 300.dp,
              height: 40.dp,
              child: CustomSearchBar(
                controller: TextEditingController(text: searchQuery),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    currentPage = 0;
                  });
                },
              ),
            ),
            SizedBox(width: 12.dp),
            DropdownButton<PaymentStatusEnum>(
              value: selectedPaymentStatus,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedPaymentStatus = value;
                    currentPage = 0;
                  });
                }
              },
              items: PaymentStatusEnum.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString().split('.').last.toUpperCase()),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(width: 12.dp),
            DropdownButton<PaymentTypeEnum>(
              value: selectedPaymentType,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedPaymentType = value;
                    currentPage = 0;
                  });
                }
              },
              items: PaymentTypeEnum.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString().split('.').last.toUpperCase()),
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
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
            SizedBox(width: 12.dp),
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
          ],
        ),
        SizedBox(height: 12.dp),
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
              const DataColumn(label: Text('Customer Name')),
              const DataColumn(label: Text('Transaction Type')),
              const DataColumn(label: Text('Customer Type')),
              const DataColumn(label: Text('Payment Status')),
              const DataColumn(label: Text('Payment Type')),
              const DataColumn(label: Text('Note')),
            ],
            rows: paginatedData
                .map((item) => DataRow(cells: [
                      DataCell(Text(item['invoiceId'] ?? '')),
                      DataCell(Text(item['date'] ?? '')),
                      DataCell(Text(item['carat'] ?? '')),
                      DataCell(Text(item['rate'] ?? '')),
                      DataCell(Text(item['amount'] ?? '')),
                      DataCell(Text(item['custName'] ?? '')),
                      DataCell(Text(
                          item['transactionType'].toString().split('.').last)),
                      DataCell(
                          Text(item['custType'].toString().split('.').last)),
                      DataCell(Text(
                          item['paymentStatus'].toString().split('.').last)),
                      DataCell(Text(
                          item['paymentType']?.toString().split('.').last ??
                              '')),
                      DataCell(Text(item['note'] ?? '-')),
                    ]))
                .toList(),
          ),
        ),
        SizedBox(height: 16),
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
