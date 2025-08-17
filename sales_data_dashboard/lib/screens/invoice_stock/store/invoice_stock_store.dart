import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/invoice_stock_model.dart';

part 'invoice_stock_store.g.dart';

class InvoiceStockStore = _InvoiceStockStore with _$InvoiceStockStore;

abstract class _InvoiceStockStore with Store {
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
  bool isFilterApplied = false;

  @observable
  String selectedRowCount = '10';

  @observable
  int totalPages = 0;

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
}
