import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
import '../../../models/sales_model.dart';

part 'sales_screen_store.g.dart';

class SalesScreenStore = _SalesScreenStore with _$SalesScreenStore;

abstract class _SalesScreenStore with Store {
  late Database db;

  @observable
  ObservableList<Sale> sales = ObservableList<Sale>();

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
  List<Sale> get paginatedData {
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
          CREATE TABLE IF NOT EXISTS sales (
            id TEXT PRIMARY KEY,
            itemName TEXT,
            size TEXT,
            carat REAL,
            rate REAL,
            amount REAL,
            paymentOption TEXT,
            paymentStatus TEXT,
            dueDays TEXT,
            description TEXT,
            brokeragePercentage REAL,
            partyId TEXT,
            firm TEXT
          )
        ''');
      },
    );
  }

  @action
  Future<void> addSale(Sale sale) async {
    await db.insert('sales', sale.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    sales.add(sale);
  }

  @action
  Future<void> fetchSales() async {
    final List<Map<String, dynamic>> maps = await db.query('sales');
    sales = ObservableList.of(maps.map((map) => Sale.fromMap(map)));
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
}
