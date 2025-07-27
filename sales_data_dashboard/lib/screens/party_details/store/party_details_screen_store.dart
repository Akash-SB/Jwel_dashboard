import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/party_model.dart';

part 'party_details_screen_store.g.dart';

class PartyDetailsStore = _PartyDetailsStore with _$PartyDetailsStore;

abstract class _PartyDetailsStore with Store {
  late Database db;

  @observable
  ObservableList<Party> partiesList = ObservableList<Party>();

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

  @action
  void setPartiesList(final List<Party> partyList) {
    partiesList = ObservableList.of(partyList);
  }

  @computed
  List<Party> get paginatedData {
    final start = currentTablePage * int.parse(selectedRowCount);
    final end =
        (start + int.parse(selectedRowCount)).clamp(0, sortedData.length);
    return sortedData.sublist(start, end);
  }

  @action
  Future<void> deleteParty(Party sale) async {
    await db.delete('parties', where: 'id = ?', whereArgs: [sale.id]);
    partiesList.remove(sale);
  }

  @action
  Future<void> addParty(Party sale) async {
    await db.insert('parties', sale.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    partiesList.add(sale);
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
  Future<void> initDb() async {
    db = await openDatabase('jewellery.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE parties (
          id TEXT PRIMARY KEY,
          name TEXT,
          address TEXT,
          mobileNumber TEXT,
          gstNumber TEXT,
          partyType TEXT,
          firm TEXT
        )
      ''');
    });
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
  List<Party> get sortedData {
    List<Party> sorted = [...filteredData];
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
  List<Party> get filteredData {
    List<Party> filtered = partiesList.toList();
    if (searchedText.isNotEmpty) {
      filtered = filtered
          .where((item) => item.toMap().values.any((v) =>
              v.toString().toLowerCase().contains(searchedText.toLowerCase())))
          .toList();
    }
    return filtered;
  }
}
