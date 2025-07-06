import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String searchQuery = '';

  @observable
  late TextEditingController ledgerController;

  @observable
  int currentTablePage = 0;

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
    if (selectedPaymentStatus != 'All') {
      filtered = filtered
          .where((item) =>
              item.paymentStatus.name.toLowerCase() ==
              selectedPaymentStatus.toLowerCase())
          .toList();
    }
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((item) => item.toMap().values.any((v) =>
              v.toString().toLowerCase().contains(searchQuery.toLowerCase())))
          .toList();
    }
    return filtered;
  }

  @computed
  List<InvoiceModel> get sortedData {
    List<InvoiceModel> sorted = [...filteredData];
    if (sortKey != null) {
      sorted.sort((a, b) {
        final aValue = a.toMap()[sortKey];
        final bValue = b.toMap()[sortKey];
        if (aValue == null || bValue == null) return 0;
        return sortAsc
            ? aValue.toString().compareTo(bValue.toString())
            : bValue.toString().compareTo(aValue.toString());
      });
    }
    return sorted;
  }

  @computed
  List<InvoiceModel> get paginatedData {
    final start = currentTablePage * 5;
    final end = (start + 5).clamp(0, sortedData.length);
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
}
