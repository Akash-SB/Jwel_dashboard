import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:sales_data_dashboard/models/firm_model.dart';
import 'package:sales_data_dashboard/models/party_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../models/sales_model.dart';
import '../../../models/stock_item.dart';

part 'sales_screen_store.g.dart';

class SalesScreenStore = _SalesScreenStore with _$SalesScreenStore;

abstract class _SalesScreenStore with Store {
  late Database db;

  @observable
  ObservableList<Sale> sales = ObservableList<Sale>();

  @observable
  ObservableList<StockItem> stocks = ObservableList<StockItem>();

  @observable
  ObservableList<Party> partiesList = ObservableList<Party>();

  @observable
  Observable<Party>? selectedParty;

  @observable
  Observable<StockItem>? selectedItem;

  @observable
  String selectedFirmType = Firm.sahajanand.name;

  @observable
  String? sortKey;

  @observable
  int totalPages = 0;

  @observable
  bool sortAsc = true;

  @observable
  String customerType = 'agent';

  @action
  void setCustomerType(final String type) {
    customerType = type;
  }

  @observable
  String searchedText = '';

  @observable
  String selectedRowCount = '10';

  @observable
  int currentTablePage = 0;

  @action
  void setSelectedParty(final Party party) {
    selectedParty = Observable(party);
  }

  @action
  void setSelectedFirmType(final String firm) {
    selectedFirmType = firm;
  }

  List<String> getListOfPartyNames() {
    final List<String> list = [];
    if (partiesList.isEmpty) {
      return list;
    } else {
      for (int i = 0; i < partiesList.length; i++) {
        if (partiesList[i].firm == selectedFirmType &&
            partiesList[i].partyType == customerType) {
          list.add(partiesList[i].name);
        }
      }
      return list;
    }
  }

  List<String> getListOfItemId() {
    final List<String> list = [];
    if (stocks.isEmpty) {
      return list;
    } else {
      for (int i = 0; i < stocks.length; i++) {
        if (partiesList[i].firm == selectedFirmType &&
            partiesList[i].partyType == customerType) {
          list.add(partiesList[i].name);
        }
      }
      return list;
    }
  }

  Party? getSelectedParty(final String name) {
    if (name.isEmpty) {
      return null;
    } else {
      for (int i = 0; i < partiesList.length; i++) {
        if (partiesList[i].name.toLowerCase() == name) {
          return partiesList[i];
        }
      }
    }
    return null;
  }

  @action
  void setSelectedStock(final StockItem stock) {
    selectedItem = Observable(stock);
  }

  @action
  void setCurrentPageIndex(final int index) {
    currentTablePage = index;
  }

  @action
  void setSearchText(final String text) {
    searchedText = text;
  }

  @action
  void setSalesList(final List<Sale> salesList) {
    sales = ObservableList.of(salesList);
  }

  @action
  void setStockList(final List<StockItem> stockList) {
    stocks = ObservableList.of(stockList);
  }

  @action
  void setPartiesList(final List<Party> partyList) {
    partiesList = ObservableList.of(partyList);
  }

  @computed
  List<Sale> get paginatedData {
    final start = currentTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
  }

  @action
  Future<void> addInStock(StockItem product) async {
    await db.insert('stock', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    stocks.add(product);
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
  List<Sale> get sortedData {
    List<Sale> sorted = [...filteredData];
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
  List<Sale> get filteredData {
    List<Sale> filtered = sales.toList();
    if (searchedText.isNotEmpty) {
      filtered = filtered
          .where((item) => item.toMap().values.any((v) =>
              v.toString().toLowerCase().contains(searchedText.toLowerCase())))
          .toList();
    }
    return filtered;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Loading state
  @observable
  bool isLoading = false;

  /// Error state
  @observable
  String? errorMessage;

  /// Firestore collection
  CollectionReference get _collection => _firestore.collection('sales');

  @action
  Future<void> fetchSales() async {
    isLoading = true;
    errorMessage = null;
    try {
      final querySnapshot = await _collection.get();
      final fetched = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Sale.fromMap(data);
      }).toList();

      sales = ObservableList<Sale>.of(fetched);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addSale(Sale sale) async {
    try {
      await _collection.doc(sale.id).set(sale.toMap());
      sales.add(sale);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> updateSale(Sale sale) async {
    try {
      await _collection.doc(sale.id).update(sale.toMap());
      final index = sales.indexWhere((s) => s.id == sale.id);
      if (index != -1) {
        sales[index] = sale;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> deleteSale(String id) async {
    try {
      await _collection.doc(id).delete();
      sales.removeWhere((s) => s.id == id);
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
