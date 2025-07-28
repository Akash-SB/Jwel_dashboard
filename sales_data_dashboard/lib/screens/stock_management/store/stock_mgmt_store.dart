import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import '../../../models/stock_item.dart';

part 'stock_mgmt_store.g.dart';

class StockStore = _StockStore with _$StockStore;

abstract class _StockStore with Store {
  @observable
  ObservableList<StockItem> stockItemList = ObservableList<StockItem>();

  @observable
  Observable<StockItem>? selectedStockItem;

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

  @action
  void setSearchText(final String text) {
    searchedText = text;
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
  CollectionReference get _collection => _firestore.collection('StockItems');

  @action
  Future<void> fetchStockList() async {
    isLoading = true;
    errorMessage = null;
    try {
      final querySnapshot = await _collection.get();
      final fetched = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return StockItem.fromMap(data);
      }).toList();

      stockItemList = ObservableList<StockItem>.of(fetched);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> addStockItem(StockItem stock) async {
    try {
      await _collection.doc(stock.itemId).set(stock.toMap());
      stockItemList.add(stock);
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future<void> updateStockItem(StockItem stock) async {
    try {
      await _collection.doc(stock.itemId).update(stock.toMap());
      final index = stockItemList.indexWhere((s) => s.itemId == stock.itemId);
      if (index != -1) {
        stockItemList[index] = stock;
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
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
