import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart' as excel;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:sales_data_dashboard/models/invoice_model.dart';
part 'invoice_store.g.dart';

class InvoiceStore = _InvoiceStore with _$InvoiceStore;

abstract class _InvoiceStore with Store {
  final CollectionReference invoicesRef =
      FirebaseFirestore.instance.collection('invoices');

  @observable
  ObservableList<InvoiceModel> invoices = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String selectedPaymentStatus = 'All';

  @observable
  String selectedPaymentType = 'All';

  @observable
  String searchQuery = '';

  @observable
  late TextEditingController ledgerController;

  @observable
  int currentTablePage = 0;

  @observable
  bool isFilterApplied = false;

  @observable
  int totalPages = 0;

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void setSelectedPaymentStatus(String status) {
    selectedPaymentStatus = status;
  }

  @action
  void setselectedPaymentTYpe(String status) {
    selectedPaymentType = status;
  }

  @action
  void initSearchController() {
    ledgerController = TextEditingController();
  }

  @action
  void setInvoices(List<InvoiceModel> invoices) {
    this.invoices = ObservableList.of(invoices);
  }

  @action
  Future<void> fetchInvoices() async {
    isLoading = true;
    errorMessage = null;
    try {
      final snapshot = await invoicesRef.get();
      invoices = ObservableList.of(
        snapshot.docs.map(
          (doc) => InvoiceModel.fromMap({
            ...doc.data() as Map<String, dynamic>,
            'invoiceId': doc.id, // Ensure the Firestore doc id is set
          }),
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addInvoice(InvoiceModel invoice) async {
    isLoading = true;
    errorMessage = null;
    try {
      final data = invoice.toMap();
      final docRef = await invoicesRef.add(data);
      invoices.add(invoice.copyWith(invoiceId: docRef.id, id: docRef.id));
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateInvoice(String id, InvoiceModel invoice) async {
    isLoading = true;
    errorMessage = null;
    try {
      await invoicesRef.doc(id).update(invoice.toMap());
      final index = invoices.indexWhere((inv) => inv.invoiceId == id);
      if (index != -1) {
        invoices[index] = invoice.copyWith(invoiceId: id, id: id);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  void isFiltersApplied() {
    isFilterApplied = searchQuery.isNotEmpty ||
        selectedPaymentStatus.toLowerCase() != 'all' ||
        selectedPaymentType.toLowerCase() != 'all' ||
        sortKey != null;
  }

  @action
  Future<void> deleteInvoice(String id) async {
    isLoading = true;
    errorMessage = null;
    try {
      await invoicesRef.doc(id).delete();
      invoices.removeWhere((inv) => inv.invoiceId == id);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @observable
  String? sortKey;

  @observable
  bool sortAsc = true;

  @computed
  List<InvoiceModel> get filteredData {
    List<InvoiceModel> filtered = invoices.toList();
    return filtered.where((item) {
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

  @computed
  List<InvoiceModel> get sortedData {
    final sorted = [...filteredData];
    if (sortKey != null) {
      sorted.sort((a, b) {
        final aValue = getFieldValue(a, sortKey!);
        final bValue = getFieldValue(b, sortKey!);
        return sortAsc ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });
    }
    return sorted;
  }

  String getFieldValue(InvoiceModel item, String key) {
    switch (key) {
      case 'invoiceId':
        return item.invoiceId;
      case 'date':
        return item.date;
      case 'productName':
        return item.productName ?? 'N/A';
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
      case 'interestDays':
        return item.interestDays ?? '';
      default:
        return '';
    }
  }

  @computed
  List<InvoiceModel> get paginatedData {
    final start = currentTablePage * 10;
    final end = (start + 10).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
  }

  @action
  void setSortKey(String? key) {
    if (sortKey == key) {
      sortAsc = !sortAsc;
    } else {
      sortKey = key;
      sortAsc = true;
    }
  }

  @action
  void clearFilters() {
    searchQuery = '';
    selectedPaymentStatus = 'All';
    selectedPaymentType = 'All';
    sortKey = null;
    sortAsc = true;
    isFilterApplied = false;
  }

  Future<void> exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.TableHelper.fromTextArray(
            data: <List<String>>[
              <String>[
                'Invoice ID',
                'Date',
                'Size',
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

  Future<void> exportExcel() async {
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
}
