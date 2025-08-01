import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import '../../../models/stock_item.dart';

part 'stock_mgmt_store.g.dart';

class StockStore = _StockStore with _$StockStore;

abstract class _StockStore with Store {
  _StockStore({
    required this.userDataStore,
  });
  final UserDataStore userDataStore;
  late final searchcontroller = TextEditingController();

  @observable
  ObservableList<StockItem> stockItemList = ObservableList<StockItem>();

  @observable
  Observable<StockItem>? selectedStockItem;

  @observable
  Observable<bool> showItemInfo = Observable<bool>(false);

  void toggleItemInfo(final bool value) {
    runInAction(() {
      showItemInfo.value = value;
    });
  }

  @action
  void setStockItemList(List<StockItem> stockList) {
    stockItemList = ObservableList.of(stockList);
  }

  @action
  void setSelectedProduct(StockItem? stock) {
    selectedStockItem = stock != null ? Observable<StockItem>(stock) : null;
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
  }

  @observable
  bool isFilterApplied = false;

  @observable
  String? sortKey;

  @observable
  int totalPages = 0;

  @observable
  bool sortAsc = true;

  @observable
  String searchedText = '';

  @observable
  String selectedRowCount = '10';

  @observable
  int currentTablePage = 0;

  @observable
  String selectedFirm = 'Sahajanand Jewellers';

  @action
  void setSelectedFirm(String firm) {
    selectedFirm = firm;
  }

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @computed
  List<StockItem> get paginatedData {
    final start = currentTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, sortedData.length);
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
  void isFiltersApplied() {
    isFilterApplied = searchedText.isNotEmpty ||
        selectedFirm != 'Sahajanand Jewellers' ||
        sortKey != null;
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
  List<StockItem> get sortedData {
    List<StockItem> sorted = [...filteredData];
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
  List<StockItem> get filteredData {
    List<StockItem> filtered = stockItemList.toList();
    return filtered.where((item) {
      final query = searchedText.toLowerCase();
      final searchedItem = item.itemId.toLowerCase().contains(query) ||
          item.hsnCode.toLowerCase().contains(query) ||
          item.carat.toString().contains(query) ||
          item.amount.toString().contains(query);
      final firmMatch = item.firm == selectedFirm;
      return searchedItem && firmMatch;
    }).toList();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Loading state
  @observable
  bool isLoading = false;

  /// Error state
  @observable
  String? errorMessage;

  /// Firestore collection
  CollectionReference get _collection => _firestore.collection('StockItems');

  @action
  Future<void> addStockItem(StockItem stock) async {
    try {
      await _collection.doc(stock.itemId).set(stock.toMap());
      stockItemList.add(stock);
      userDataStore.stockList.add(stock);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> updateStockItem(StockItem stock) async {
    try {
      await _collection.doc(stock.itemId).update(stock.toMap());
      final index = stockItemList.indexWhere((s) => s.itemId == stock.itemId);
      final indexUserData =
          userDataStore.stockList.indexWhere((s) => s.itemId == stock.itemId);
      if (index != -1) {
        stockItemList[index] = stock;
      }
      if (indexUserData != -1) {
        userDataStore.stockList[indexUserData] = stock;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> deleteStockItem(String id) async {
    try {
      await _collection.doc(id).delete();
      stockItemList.removeWhere((s) => s.itemId == id);
      userDataStore.stockList.removeWhere((s) => s.itemId == id);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  void clearAllFilters() {
    searchcontroller.text = '';
    setSelectedFirm('Sahajanand Jewellers');
    sortKey = null;
    setSearchText('');
    setCurrentPageIndex(0);
    isFilterApplied = false;
  }
}
