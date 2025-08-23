import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/invoice_stock_ledger_model.dart';
import 'package:sales_data_dashboard/models/invoice_stock_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';

import '../../../models/app_enum.dart';

part 'invoice_stock_store.g.dart';

class InvoiceStockStore = _InvoiceStockStore with _$InvoiceStockStore;

abstract class _InvoiceStockStore with Store {
  _InvoiceStockStore(this.userDataStore);
  final UserDataStore userDataStore;
  final searchcontroller = TextEditingController();

  @observable
  Observable<bool> showItemInfo = Observable<bool>(false);

  @observable
  bool isLoading = false;

  @observable
  String searchedText = '';

  @observable
  int currentTablePage = 0;

  @observable
  int totalinfoPages = 0;

  @observable
  bool isInfoFilterApplied = false;

  @observable
  bool isFilterApplied = false;

  @observable
  String selectedRowCount = '10';

  @observable
  int currentInfoTablePage = 0;

  @observable
  int totalPages = 0;

  @observable
  String selectedinfoTransType = 'All';

  @observable
  ObservableList<InvoiceStockLedgerModel> stockledgerList =
      ObservableList<InvoiceStockLedgerModel>();

  @action
  void setSelectedInfoTransType(final String value) {
    selectedinfoTransType = value;
  }

  @action
  void filterLedgerList() {
    List<InvoiceStockLedgerModel> ledgers = [];
    ledgers.addAll(
      userDataStore.invoices
          .where(
              (final invoice) => invoice.productName == selectedStock?.itemId)
          .map(
            (final invoice) => InvoiceStockLedgerModel(
              date: invoice.date,
              itemName: invoice.productName ?? '',
              partyName: invoice.custName,
              paymentType: invoice.transactionType.name,
              credit: invoice.transactionType == TransactionTypeEnum.purchase
                  ? double.tryParse(invoice.amount)
                  : null,
              debit: invoice.transactionType == TransactionTypeEnum.sell
                  ? double.tryParse(invoice.amount)
                  : null,
            ),
          ),
    );

    ledgers.sort((a, b) => b.date.compareTo(a.date));
    stockledgerList.clear();
    setLedgerList(ledgers);
  }

  @computed
  List<InvoiceStockLedgerModel> get filteredLedgerData {
    List<InvoiceStockLedgerModel> filtered = stockledgerList.toList();
    return filtered.where((item) {
      return item.paymentType.toLowerCase() ==
          selectedinfoTransType.toLowerCase();
    }).toList();
  }

  @action
  void setLedgerList(List<InvoiceStockLedgerModel> ledgerListValue) {
    stockledgerList = ObservableList.of(ledgerListValue);
  }

  @computed
  List<InvoiceStockLedgerModel> get paginatedInfoData {
    final start = currentInfoTablePage * int.parse(selectedRowCount);
    final end = (start + int.parse(selectedRowCount))
        .clamp(0, filteredLedgerData.length);
    return filteredLedgerData.sublist(start, end);
  }

  @observable
  ObservableList<InvoiceStockModel> stockList = ObservableList();

  @observable
  InvoiceStockModel? selectedStock;

  @observable
  String selectedFirm = 'Sahajanand Gems';

  @action
  void setSelectedFirm(final String value) {
    selectedFirm = value;
  }

  void toggleItemInfo(final bool value) {
    runInAction(() {
      showItemInfo.value = value;
    });
  }

  @action
  void setLoading(bool value) {
    isLoading = value;
  }

  @action
  void setTotalinfoPages(final int index) {
    totalinfoPages = index;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Firestore collection
  CollectionReference get _collection =>
      _firestore.collection('InvoiceStockItems');

  @action
  Future<void> fetchStockItems() async {
    isLoading = true;
    try {
      final snapshot = await _collection.get();
      final items = snapshot.docs
          .map((doc) => InvoiceStockModel.fromMap({
                ...doc.data() as Map<String, dynamic>,
              }))
          .toList();
      setStockList(items);
    } catch (e) {
      print('Error fetching stock items: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addStockItem(InvoiceStockModel item) async {
    isLoading = true;
    try {
      await _collection.add(item.toJson());
      stockList.add(item);
    } catch (e) {
      print('Error adding stock item: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateStockItem(InvoiceStockModel item) async {
    isLoading = true;
    try {
      await _collection.doc(item.itemId).update(item.toJson());
      final index = stockList.indexWhere((i) => i.itemId == item.itemId);
      if (index != -1) {
        stockList[index] = item;
      }
    } catch (e) {
      print('Error updating stock item: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteStockItem(InvoiceStockModel item) async {
    isLoading = true;
    try {
      await _collection.doc(item.itemId).delete();
      stockList.remove(item);
    } catch (e) {
      print('Error deleting stock item: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  void calculateInfoTotalPages() {
    if (filteredLedgerData.isEmpty) {
      totalinfoPages = 0;
    } else {
      totalinfoPages =
          (filteredLedgerData.length / int.parse(selectedRowCount)).ceil();
    }
  }

  @action
  void setStockList(final List<InvoiceStockModel> list) {
    stockList.clear();
    stockList.addAll(list);
  }

  @action
  void setSelectedStockItem(InvoiceStockModel item) {
    selectedStock = item;
  }

  @action
  void calculateTotalPages() {
    if (filteredData.isEmpty) {
      totalPages = 0;
    } else {
      totalPages = (filteredData.length / int.parse(selectedRowCount)).ceil();
    }
  }

  @action
  void isInfoFilterAppliedCheck() {
    isInfoFilterApplied = selectedinfoTransType != 'All';
  }

  @computed
  List<InvoiceStockModel> get paginatedData {
    final start = currentTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, filteredData.length);
    return filteredData.sublist(start, end);
  }

  @action
  void isFiltersApplied() {
    isFilterApplied =
        searchedText.isNotEmpty || selectedFirm != 'Sahajanand Gems';
  }

  @computed
  List<InvoiceStockModel> get filteredData {
    List<InvoiceStockModel> filtered = stockList.toList();
    return filtered.where((item) {
      final query = searchedText.toLowerCase();
      final searchedItem = item.itemName.toLowerCase().contains(query) ||
          item.hsdCode.toLowerCase().contains(query) ||
          item.itemWeight.toString().contains(query) ||
          item.amount.toString().contains(query);
      final firmMatch = item.firm.toLowerCase() == selectedFirm.toLowerCase();
      return searchedItem && firmMatch;
    }).toList();
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
  }

  @action
  void clearAllFilters() {
    searchcontroller.text = '';
    setSelectedFirm('Sahajanand Gems');
    setSearchText('');
    setCurrentPageIndex(0);
    isFilterApplied = false;
  }

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @action
  void setInvoiceStockList(List<InvoiceStockModel> stockItems) {
    stockList = ObservableList.of(stockItems);
  }

  @action
  void setCurrentInfoTablePage(final int index) {
    currentInfoTablePage = index;
  }

  @action
  void clearInfoFilter() {
    setSelectedInfoTransType('All');
    setCurrentInfoTablePage(0);
    isInfoFilterApplied = false;
  }
}
