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

  late final _$selectedPartyAtom =
      Atom(name: '_PartyDetailsStore.selectedParty', context: context);

  @override
  Observable<Party>? get selectedParty {
    _$selectedPartyAtom.reportRead();
    return super.selectedParty;
  }

  @override
  set selectedParty(Observable<Party>? value) {
    _$selectedPartyAtom.reportWrite(value, super.selectedParty, () {
      super.selectedParty = value;
    });
  }

  late final _$selectedFilterTransactionTypeAtom = Atom(
      name: '_PartyDetailsStore.selectedFilterTransactionType',
      context: context);

  @override
  TransactionTypeEnum get selectedFilterTransactionType {
    _$selectedFilterTransactionTypeAtom.reportRead();
    return super.selectedFilterTransactionType;
  }

  @override
  set selectedFilterTransactionType(TransactionTypeEnum value) {
    _$selectedFilterTransactionTypeAtom
        .reportWrite(value, super.selectedFilterTransactionType, () {
      super.selectedFilterTransactionType = value;
    });
  }

  late final _$showPartyInfoAtom =
      Atom(name: '_PartyDetailsStore.showPartyInfo', context: context);

  @override
  Observable<bool> get showPartyInfo {
    _$showPartyInfoAtom.reportRead();
    return super.showPartyInfo;
  }

  @override
  set showPartyInfo(Observable<bool> value) {
    _$showPartyInfoAtom.reportWrite(value, super.showPartyInfo, () {
      super.showPartyInfo = value;
    });
  }

  late final _$isFilterAppliedAtom =
      Atom(name: '_PartyDetailsStore.isFilterApplied', context: context);

  @override
  bool get isFilterApplied {
    _$isFilterAppliedAtom.reportRead();
    return super.isFilterApplied;
  }

  @override
  set isFilterApplied(bool value) {
    _$isFilterAppliedAtom.reportWrite(value, super.isFilterApplied, () {
      super.isFilterApplied = value;
    });
  }

  late final _$selectedFormPartyTypeAtom =
      Atom(name: '_PartyDetailsStore.selectedFormPartyType', context: context);

  @override
  String get selectedFormPartyType {
    _$selectedFormPartyTypeAtom.reportRead();
    return super.selectedFormPartyType;
  }

  @override
  set selectedFormPartyType(String value) {
    _$selectedFormPartyTypeAtom.reportWrite(value, super.selectedFormPartyType,
        () {
      super.selectedFormPartyType = value;
    });
  }

  late final _$selectedFormFirmTypeAtom =
      Atom(name: '_PartyDetailsStore.selectedFormFirmType', context: context);

  @override
  String get selectedFormFirmType {
    _$selectedFormFirmTypeAtom.reportRead();
    return super.selectedFormFirmType;
  }

  @override
  set selectedFormFirmType(String value) {
    _$selectedFormFirmTypeAtom.reportWrite(value, super.selectedFormFirmType,
        () {
      super.selectedFormFirmType = value;
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

  late final _$selectedFilterFirmAtom =
      Atom(name: '_PartyDetailsStore.selectedFilterFirm', context: context);

  @override
  String get selectedFilterFirm {
    _$selectedFilterFirmAtom.reportRead();
    return super.selectedFilterFirm;
  }

  @override
  set selectedFilterFirm(String value) {
    _$selectedFilterFirmAtom.reportWrite(value, super.selectedFilterFirm, () {
      super.selectedFilterFirm = value;
    });
  }

  late final _$selectedFilterPartyTypeAtom = Atom(
      name: '_PartyDetailsStore.selectedFilterPartyType', context: context);

  @override
  String get selectedFilterPartyType {
    _$selectedFilterPartyTypeAtom.reportRead();
    return super.selectedFilterPartyType;
  }

  @override
  set selectedFilterPartyType(String value) {
    _$selectedFilterPartyTypeAtom
        .reportWrite(value, super.selectedFilterPartyType, () {
      super.selectedFilterPartyType = value;
    });
  }

  late final _$addPartyDetailsAsyncAction =
      AsyncAction('_PartyDetailsStore.addPartyDetails', context: context);

  @override
  Future<void> addPartyDetails(Party party) {
    return _$addPartyDetailsAsyncAction.run(() => super.addPartyDetails(party));
  }

  late final _$updatePartyDetailsAsyncAction =
      AsyncAction('_PartyDetailsStore.updatePartyDetails', context: context);

  @override
  Future<void> updatePartyDetails(Party party) {
    return _$updatePartyDetailsAsyncAction
        .run(() => super.updatePartyDetails(party));
  }

  late final _$deletePartyDetailsAsyncAction =
      AsyncAction('_PartyDetailsStore.deletePartyDetails', context: context);

  @override
  Future<void> deletePartyDetails(String id) {
    return _$deletePartyDetailsAsyncAction
        .run(() => super.deletePartyDetails(id));
  }

  late final _$_PartyDetailsStoreActionController =
      ActionController(name: '_PartyDetailsStore', context: context);

  @override
  void setSelectedFilterTransactionType(TransactionTypeEnum value) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSelectedFilterTransactionType');
    try {
      return super.setSelectedFilterTransactionType(value);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedParty(Party? party) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSelectedParty');
    try {
      return super.setSelectedParty(party);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePartyInfo(bool value) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.togglePartyInfo');
    try {
      return super.togglePartyInfo(value);
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
  void setSelectedFormPartyType(String value) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSelectedFormPartyType');
    try {
      return super.setSelectedFormPartyType(value);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFormFirmType(String value) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSelectedFormFirmType');
    try {
      return super.setSelectedFormFirmType(value);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String setPartyId(String itemName, String partyType) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setPartyId');
    try {
      return super.setPartyId(itemName, partyType);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

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
  void setSelectedFilterPartyType(String value) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSelectedFilterPartyType');
    try {
      return super.setSelectedFilterPartyType(value);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFilterFirm(String firm) {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.setSelectedFilterFirm');
    try {
      return super.setSelectedFilterFirm(firm);
    } finally {
      _$_PartyDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isFiltersApplied() {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.isFiltersApplied');
    try {
      return super.isFiltersApplied();
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
  void clearAllFilters() {
    final _$actionInfo = _$_PartyDetailsStoreActionController.startAction(
        name: '_PartyDetailsStore.clearAllFilters');
    try {
      return super.clearAllFilters();
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
selectedParty: ${selectedParty},
selectedFilterTransactionType: ${selectedFilterTransactionType},
showPartyInfo: ${showPartyInfo},
isFilterApplied: ${isFilterApplied},
selectedFormPartyType: ${selectedFormPartyType},
selectedFormFirmType: ${selectedFormFirmType},
searchedText: ${searchedText},
selectedRowCount: ${selectedRowCount},
currentTablePage: ${currentTablePage},
selectedFilterFirm: ${selectedFilterFirm},
selectedFilterPartyType: ${selectedFilterPartyType},
paginatedData: ${paginatedData},
sortedData: ${sortedData},
filteredData: ${filteredData}
    ''';
  }
}
