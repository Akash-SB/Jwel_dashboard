import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/stock_party_ledger.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';
import '../../../models/app_enum.dart';
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
  ObservableList<StockPartyLedger> ledgerList =
      ObservableList<StockPartyLedger>();

  @observable
  Observable<StockItem>? selectedStockItem;

  @observable
  String selectedTransType = 'All';

  @observable
  String selectedTransStatus = 'All';

  @action
  void setSelectedTransType(final value) {
    selectedTransType = value;
  }

  @action
  void setSelectedTransStatus(final value) {
    selectedTransStatus = value;
  }

  @observable
  TransactionTypeEnum selectedFilterTransactionType = TransactionTypeEnum.sell;

  @action
  void setSelectedFilterTransactionType(TransactionTypeEnum value) {
    selectedFilterTransactionType = value;
  }

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
  void setLedgerList(List<StockPartyLedger> ledgerListValue) {
    ledgerList = ObservableList.of(ledgerListValue);
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
  bool isInfoFilterApplied = false;

  @observable
  String? sortKey;

  @observable
  int totalPages = 0;

  @observable
  int totalinfoPages = 0;

  @observable
  bool sortAsc = true;

  @observable
  String searchedText = '';

  @observable
  String selectedRowCount = '10';

  @observable
  int currentTablePage = 0;

  @observable
  int currentInfoTablePage = 0;

  @observable
  String selectedFirm = 'Sahajanand Gems';

  @action
  void setSelectedFirm(String firm) {
    selectedFirm = firm;
  }

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @action
  void setTotalinfoPages(final int index) {
    totalinfoPages = index;
  }

  @action
  void setCurrentInfoTablePage(final int index) {
    currentInfoTablePage = index;
  }

  @computed
  List<StockItem> get paginatedData {
    final start = currentTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
  }

  @computed
  List<StockPartyLedger> get paginatedInfoData {
    final start = currentInfoTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, filteredInfoData.length);
    return filteredInfoData.sublist(start, end);
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
        selectedFirm != 'Sahajanand Gems' ||
        sortKey != null;
  }

  @action
  void isInfoFilterAppliedCheck() {
    isInfoFilterApplied =
        selectedTransType != 'All' || selectedTransStatus != 'All';
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
  void calculateInfoTotalPages() {
    if (filteredInfoData.isEmpty) {
      totalinfoPages = 0;
    } else {
      totalinfoPages =
          (filteredInfoData.length / int.parse(selectedRowCount)).ceil();
    }
  }

  @action
  void filterLedgerList() {
    List<StockPartyLedger> ledgers = [];
    ledgers.addAll(
      userDataStore.salesList
          .where((final sale) =>
              sale.stockDetails.itemId == selectedStockItem?.value.itemId)
          .map(
            (final sale) => StockPartyLedger(
              id: sale.id,
              createdAt: sale.createdAt,
              customerId: sale.partyDetails.id,
              customerName: sale.partyDetails.name,
              productId: sale.stockDetails.itemId,
              quantity: sale.stockDetails.availableQuantity.toString(),
              amount: sale.stockDetails.amount.toString(),
              transType: TransType.sale.name,
              description: sale.description,
              dueDays: sale.dueDays,
              agentName: sale.agentDetails?.name ?? 'NA',
              paymentStatus: '',
              firm: '',
            ),
          ),
    );
    ledgers.addAll(
      userDataStore.purchaseList
          .where((final purchase) =>
              purchase.stockDetails.itemId == selectedStockItem?.value.itemId)
          .map(
            (final purchase) => StockPartyLedger(
              id: purchase.id,
              createdAt: purchase.createdAt,
              customerId: purchase.partyDetails.id,
              customerName: purchase.partyDetails.name,
              productId: purchase.stockDetails.itemId,
              quantity: purchase.stockDetails.availableQuantity.toString(),
              amount: purchase.stockDetails.amount.toString(),
              paymentStatus: purchase.paymentStatus,
              firm: purchase.firm,
              transType: TransType.purchase.name,
              description: purchase.description,
              agentName: purchase.agentDetails?.name ?? 'NA',
            ),
          ),
    );
    ledgers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    ledgerList.clear();
    setLedgerList(ledgers);
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
          (item.hsnCode != null &&
              item.hsnCode!.toLowerCase().contains(query)) ||
          item.amount.toString().contains(query);
      return searchedItem;
    }).toList();
  }

  @computed
  List<StockPartyLedger> get filteredInfoData {
    List<StockPartyLedger> filtered = ledgerList.toList();
    return filtered.where((item) {
      final typeMatch = selectedTransType == 'All'
          ? true
          : item.transType == selectedTransType;
      final statusType = selectedTransStatus == 'All'
          ? true
          : item.paymentStatus.toLowerCase() ==
              selectedTransStatus.toLowerCase();
      return typeMatch && statusType;
    }).toList();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Loading state
  @observable
  bool isLoading = false;

  /// Error state
  @observable
  String? errorMessage;

  @action
  void setErrorMessage(String message) {
    errorMessage = message;
  }

  /// Firestore collection
  CollectionReference get _collection => _firestore.collection('StockItems');

  @action
  Future<void> addStockItem(StockItem stock) async {
    try {
      await _collection.doc(stock.itemId).set(stock.toMap());
      stockItemList.add(stock);
      userDataStore.stockList.add(stock);
    } catch (e) {
      setErrorMessage(e.toString());
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
      setErrorMessage(e.toString());
    }
  }

  @action
  Future<void> deleteStockItem(String id) async {
    try {
      await _collection.doc(id).delete();
      stockItemList.removeWhere((s) => s.itemId == id);
      userDataStore.stockList.removeWhere((s) => s.itemId == id);
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  @action
  void clearAllFilters() {
    searchcontroller.text = '';
    setSelectedFirm('Sahajanand Gems');
    sortKey = null;
    setSearchText('');
    setCurrentPageIndex(0);
    isFilterApplied = false;
  }

  @action
  void clearInfoFilter() {
    setSelectedTransStatus('All');
    setSelectedTransType('All');
    setCurrentInfoTablePage(0);
    isInfoFilterApplied = false;
  }
}
