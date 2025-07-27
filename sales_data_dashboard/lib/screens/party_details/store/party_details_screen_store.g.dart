// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_details_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PartyDetailsStore on _PartyDetailsStore, Store {
  Computed<List<Party>>? _$paginatedDataComputed;

  @override
  List<Party> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<Party>>(() => super.paginatedData,
              name: '_PartyDetailsStore.paginatedData'))
      .value;
  Computed<List<Party>>? _$sortedDataComputed;

  @override
  List<Party> get sortedData =>
      (_$sortedDataComputed ??= Computed<List<Party>>(() => super.sortedData,
              name: '_PartyDetailsStore.sortedData'))
          .value;
  Computed<List<Party>>? _$filteredDataComputed;

  @override
  List<Party> get filteredData => (_$filteredDataComputed ??=
          Computed<List<Party>>(() => super.filteredData,
              name: '_PartyDetailsStore.filteredData'))
      .value;

  late final _$partiesListAtom =
      Atom(name: '_PartyDetailsStore.partiesList', context: context);

  @override
  ObservableList<Party> get partiesList {
    _$partiesListAtom.reportRead();
    return super.partiesList;
  }

  @override
  set partiesList(ObservableList<Party> value) {
    _$partiesListAtom.reportWrite(value, super.partiesList, () {
      super.partiesList = value;
    });
  }

  late final _$sortKeyAtom =
      Atom(name: '_PartyDetailsStore.sortKey', context: context);

  @override
  String? get sortKey {
    _$sortKeyAtom.reportRead();
    return super.sortKey;
  }

  @override
  set sortKey(String? value) {
    _$sortKeyAtom.reportWrite(value, super.sortKey, () {
      super.sortKey = value;
    });
  }

  late final _$totalPagesAtom =
      Atom(name: '_PartyDetailsStore.totalPages', context: context);

  @override
  int get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  late final _$sortAscAtom =
      Atom(name: '_PartyDetailsStore.sortAsc', context: context);

  @override
  bool get sortAsc {
    _$sortAscAtom.reportRead();
    return super.sortAsc;
  }

  @override
  set sortAsc(bool value) {
    _$sortAscAtom.reportWrite(value, super.sortAsc, () {
      super.sortAsc = value;
    });
  }

  late final _$searchedTextAtom =
      Atom(name: '_PartyDetailsStore.searchedText', context: context);

  @override
  String get searchedText {
    _$searchedTextAtom.reportRead();
    return super.searchedText;
  }

  @override
  set searchedText(String value) {
    _$searchedTextAtom.reportWrite(value, super.searchedText, () {
      super.searchedText = value;
    });
  }

  late final _$selectedRowCountAtom =
      Atom(name: '_PartyDetailsStore.selectedRowCount', context: context);

  @override
  String get selectedRowCount {
    _$selectedRowCountAtom.reportRead();
    return super.selectedRowCount;
  }

  @override
  set selectedRowCount(String value) {
    _$selectedRowCountAtom.reportWrite(value, super.selectedRowCount, () {
      super.selectedRowCount = value;
    });
  }

  late final _$currentTablePageAtom =
      Atom(name: '_PartyDetailsStore.currentTablePage', context: context);

  @override
  int get currentTablePage {
    _$currentTablePageAtom.reportRead();
    return super.currentTablePage;
  }

  @override
  set currentTablePage(int value) {
    _$currentTablePageAtom.reportWrite(value, super.currentTablePage, () {
      super.currentTablePage = value;
    });
  }

  late final _$deletePartyAsyncAction =
      AsyncAction('_PartyDetailsStore.deleteParty', context: context);

  @override
  Future<void> deleteParty(Party sale) {
    return _$deletePartyAsyncAction.run(() => super.deleteParty(sale));
  }

  late final _$addPartyAsyncAction =
      AsyncAction('_PartyDetailsStore.addParty', context: context);

  @override
  Future<void> addParty(Party sale) {
    return _$addPartyAsyncAction.run(() => super.addParty(sale));
  }

  late final _$initDbAsyncAction =
      AsyncAction('_PartyDetailsStore.initDb', context: context);

  @override
  Future<void> initDb() {
    return _$initDbAsyncAction.run(() => super.initDb());
  }

  late final _$_PartyDetailsStoreActionController =
      ActionController(name: '_PartyDetailsStore', context: context);

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPartiesList(List<Party> partyList) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setPartiesList');
    try {
      return super.setPartiesList(partyList);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
partiesList: ${partiesList},
sortKey: ${sortKey},
totalPages: ${totalPages},
sortAsc: ${sortAsc},
searchedText: ${searchedText},
selectedRowCount: ${selectedRowCount},
currentTablePage: ${currentTablePage},
paginatedData: ${paginatedData},
sortedData: ${sortedData},
filteredData: ${filteredData}
    ''';
  }
}
