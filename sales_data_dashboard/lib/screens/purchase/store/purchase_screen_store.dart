import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/purchase_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/party_model.dart';
import '../../../models/stock_item.dart';

part 'purchase_screen_store.g.dart';

class PurchaseScreenStore = _PurchaseScreenStore with _$PurchaseScreenStore;

abstract class _PurchaseScreenStore with Store {
  late Database db;

  @observable
  ObservableList<Purchase> purchaseList = ObservableList<Purchase>();

  @observable
  ObservableList<StockItem> stockList = ObservableList<StockItem>();

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
  Future<void> initDb() async {
    db = await openDatabase(
      'jewellery.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
         CREATE TABLE IF NOT EXISTS purchase (
  id TEXT PRIMARY KEY,
  partyDetails TEXT,
  stockDetails TEXT,
  paymentOption TEXT,
  paymentStatus TEXT,
  description TEXT,
  createdAt TEXT,
  synced INTEGER,
  firm TEXT
);
        ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS stock (
  itemId TEXT PRIMARY KEY,
  itemName TEXT,
  size TEXT,
  rate REAL,
  carat REAL,
  availableQuantity REAL,
  amount REAL,
  description TEXT,
  synced INTEGER,
  firm TEXT
);
        ''');
      },
    );
  }

  @action
  Future<void> addPurchase(Purchase purchase) async {
    await db.insert('purchase', purchase.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    purchaseList.add(purchase);
  }

  @action
  Future<void> addInStock(StockItem item) async {
    await db.insert('stock', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    stockList.add(item);
  }

  @action
  Future<void> deletePurchase(Purchase sale) async {
    await db.delete('purchase', where: 'id = ?', whereArgs: [sale.id]);
    purchaseList.remove(sale);
  }

  @action
  Future<void> fetchPurchases() async {
    final List<Map<String, dynamic>> maps = await db.query('purchase');
    purchaseList = ObservableList.of(maps.map((map) => Purchase.fromMap(map)));
  }

  @action
  Future<void> fetchStockItem() async {
    final List<Map<String, dynamic>> maps = await db.query('stock');
    stockList = ObservableList.of(maps.map((map) => StockItem.fromMap(map)));
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

  // List<String> getListOfPartyNames() {
  //   final List<String> list = [];
  //   if (partiesList.isEmpty) {
  //     return list;
  //   } else {
  //     for (int i = 0; i < partiesList.length; i++) {
  //       if (partiesList[i].firm == selectedFirmType &&
  //           partiesList[i].partyType == customerType) {
  //         list.add(partiesList[i].name);
  //       }
  //     }
  //     return list;
  //   }
  // }

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
}
