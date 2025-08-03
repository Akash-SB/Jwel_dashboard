import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/purchase_model.dart';
import 'package:sales_data_dashboard/screens/home/store/userdata_store.dart';

import '../../../models/party_model.dart';
import '../../../models/stock_item.dart';

part 'purchase_screen_store.g.dart';

class PurchaseScreenStore = _PurchaseScreenStore with _$PurchaseScreenStore;

abstract class _PurchaseScreenStore with Store {
  _PurchaseScreenStore({
    required this.userDataStore,
  });

  final UserDataStore userDataStore;

  @observable
  ObservableList<Purchase> purchaseList = ObservableList<Purchase>();

  @observable
  ObservableList<StockItem> stockList = ObservableList<StockItem>();

  @observable
  String selectedPartyType = 'agent';

  @observable
  String? selectedPaymentType;

  @observable
  String selectedPaymentStatus = 'unpaid';

  @observable
  StockItem? selectedStockItem;

  @action
  void setSelectedStockItem(StockItem? item) {
    selectedStockItem = item;
  }

  @action
  void setSelectedPaymentType(String? type) {
    selectedPaymentType = type;
  }

  @action
  void setSelectedPaymentStatus(String? status) {
    selectedPaymentStatus = status ?? 'unpaid';
  }

  @observable
  String selectedFirmType = 'Sahajanand Jewellers';

  @observable
  String itemSelectionType = 'existing';

  @observable
  Party? selectedParty;

  @action
  void setselectedParty(Party? party) {
    selectedParty = party;
  }

  @action
  Future<void> addPartyDetails(Party party) async {
    try {
      await _collection.doc(party.id).set(party.toMap());
      userDataStore.partiesList.add(party);
      partiesList.add(party);
    } catch (e) {
      print('Error adding party: $e');
    }
  }

  @action
  void setItemSelectionType(String type) {
    itemSelectionType = type;
  }

  @action
  void setSelectedFirm(String firm) {
    selectedFirmType = firm;
  }

  @action
  void setSelectedPartyType(String type) {
    selectedPartyType = type;
  }

  @action
  List<String> getPartyIds() {
    return partiesList
        .where((party) =>
            party.partyType.toLowerCase() == selectedPartyType.toLowerCase())
        .map((party) => party.id)
        .toList();
  }

  @action
  Party? getPartyById(String partyId) {
    return partiesList.firstWhere(
      (party) => party.id == partyId,
    );
  }

  @action
  void setPurchaseList(List<Purchase> list) {
    purchaseList = ObservableList<Purchase>.of(list);
  }

  @action
  void setStockList(List<StockItem> list) {
    stockList = ObservableList<StockItem>.of(list);
  }

  List<String> getStockListNames() {
    return stockList.map((item) => item.itemId).toList();
  }

  StockItem? getStockItemById(String itemId) {
    return stockList.firstWhere(
      (item) => item.itemId == itemId,
    );
  }

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

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @observable
  ObservableList<Party> partiesList = ObservableList<Party>();

  @action
  void setPartiesList(List<Party> list) {
    partiesList = ObservableList<Party>.of(list);
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
  }

  @computed
  List<Purchase> get paginatedData {
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
  void calculateTotalPages() {
    if (filteredData.isEmpty) {
      totalPages = 0;
    } else {
      totalPages = (filteredData.length / int.parse(selectedRowCount)).ceil();
    }
  }

  @computed
  List<Purchase> get sortedData {
    List<Purchase> sorted = [...filteredData];
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
  List<Purchase> get filteredData {
    List<Purchase> filtered = purchaseList.toList();
    if (searchedText.isNotEmpty) {
      filtered = filtered
          .where((item) => item.toMap().values.any((v) =>
              v.toString().toLowerCase().contains(searchedText.toLowerCase())))
          .toList();
    }
    return filtered;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Collection reference in Firestore
  CollectionReference get _collection => _firestore.collection('purchases');

  /// Reactive list of purchases
  @observable
  ObservableList<Purchase> purchases = ObservableList<Purchase>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> addPurchase(Purchase purchase) async {
    try {
      await _collection.doc(purchase.id).set(purchase.toMap());
      purchases.add(purchase);
      userDataStore.purchaseList.add(purchase);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> addStockItem(StockItem stock) async {
    try {
      await _collection.doc(stock.itemId).set(stock.toMap());
      stockList.add(stock);
      userDataStore.stockList.add(stock);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> updateStockItem(StockItem stock) async {
    try {
      await _collection.doc(stock.itemId).update(stock.toMap());
      final index = stockList.indexWhere((s) => s.itemId == stock.itemId);
      if (index != -1) {
        stockList[index] = stock;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> updatePurchase(Purchase purchase) async {
    try {
      await _collection.doc(purchase.id).update(purchase.toMap());
      final index = purchases.indexWhere((p) => p.id == purchase.id);
      final userIndex =
          userDataStore.purchaseList.indexWhere((p) => p.id == purchase.id);
      if (index != -1) {
        purchases[index] = purchase;
      }
      if (userIndex != -1) {
        userDataStore.purchaseList[userIndex] = purchase;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> deletePurchase(String id) async {
    try {
      await _collection.doc(id).delete();
      purchases.removeWhere((p) => p.id == id);
      userDataStore.purchaseList.removeWhere((p) => p.id == id);
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
