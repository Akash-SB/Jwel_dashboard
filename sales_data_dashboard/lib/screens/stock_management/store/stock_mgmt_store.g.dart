// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_mgmt_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StockStore on _StockStore, Store {
  Computed<List<StockItem>>? _$paginatedDataComputed;

  @override
  List<StockItem> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<StockItem>>(() => super.paginatedData,
              name: '_StockStore.paginatedData'))
      .value;
  Computed<List<StockPartyLedger>>? _$paginatedInfoDataComputed;

  @override
  List<StockPartyLedger> get paginatedInfoData =>
      (_$paginatedInfoDataComputed ??= Computed<List<StockPartyLedger>>(
              () => super.paginatedInfoData,
              name: '_StockStore.paginatedInfoData'))
          .value;
  Computed<List<StockItem>>? _$sortedDataComputed;

  @override
  List<StockItem> get sortedData => (_$sortedDataComputed ??=
          Computed<List<StockItem>>(() => super.sortedData,
              name: '_StockStore.sortedData'))
      .value;
  Computed<List<StockItem>>? _$filteredDataComputed;

  @override
  List<StockItem> get filteredData => (_$filteredDataComputed ??=
          Computed<List<StockItem>>(() => super.filteredData,
              name: '_StockStore.filteredData'))
      .value;
  Computed<List<StockPartyLedger>>? _$filteredInfoDataComputed;

  @override
  List<StockPartyLedger> get filteredInfoData => (_$filteredInfoDataComputed ??=
          Computed<List<StockPartyLedger>>(() => super.filteredInfoData,
              name: '_StockStore.filteredInfoData'))
      .value;

  late final _$stockItemListAtom =
      Atom(name: '_StockStore.stockItemList', context: context);

  @override
  ObservableList<StockItem> get stockItemList {
    _$stockItemListAtom.reportRead();
    return super.stockItemList;
  }

  @override
  set stockItemList(ObservableList<StockItem> value) {
    _$stockItemListAtom.reportWrite(value, super.stockItemList, () {
      super.stockItemList = value;
    });
  }

  late final _$ledgerListAtom =
      Atom(name: '_StockStore.ledgerList', context: context);

  @override
  ObservableList<StockPartyLedger> get ledgerList {
    _$ledgerListAtom.reportRead();
    return super.ledgerList;
  }

  @override
  set ledgerList(ObservableList<StockPartyLedger> value) {
    _$ledgerListAtom.reportWrite(value, super.ledgerList, () {
      super.ledgerList = value;
    });
  }

  late final _$selectedStockItemAtom =
      Atom(name: '_StockStore.selectedStockItem', context: context);

  @override
  Observable<StockItem>? get selectedStockItem {
    _$selectedStockItemAtom.reportRead();
    return super.selectedStockItem;
  }

  @override
  set selectedStockItem(Observable<StockItem>? value) {
    _$selectedStockItemAtom.reportWrite(value, super.selectedStockItem, () {
      super.selectedStockItem = value;
    });
  }

  late final _$selectedTransTypeAtom =
      Atom(name: '_StockStore.selectedTransType', context: context);

  @override
  String get selectedTransType {
    _$selectedTransTypeAtom.reportRead();
    return super.selectedTransType;
  }

  @override
  set selectedTransType(String value) {
    _$selectedTransTypeAtom.reportWrite(value, super.selectedTransType, () {
      super.selectedTransType = value;
    });
  }

  late final _$selectedTransStatusAtom =
      Atom(name: '_StockStore.selectedTransStatus', context: context);

  @override
  String get selectedTransStatus {
    _$selectedTransStatusAtom.reportRead();
    return super.selectedTransStatus;
  }

  @override
  set selectedTransStatus(String value) {
    _$selectedTransStatusAtom.reportWrite(value, super.selectedTransStatus, () {
      super.selectedTransStatus = value;
    });
  }

  late final _$selectedFilterTransactionTypeAtom =
      Atom(name: '_StockStore.selectedFilterTransactionType', context: context);

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

  late final _$showItemInfoAtom =
      Atom(name: '_StockStore.showItemInfo', context: context);

  @override
  Observable<bool> get showItemInfo {
    _$showItemInfoAtom.reportRead();
    return super.showItemInfo;
  }

  @override
  set showItemInfo(Observable<bool> value) {
    _$showItemInfoAtom.reportWrite(value, super.showItemInfo, () {
      super.showItemInfo = value;
    });
  }

  late final _$isFilterAppliedAtom =
      Atom(name: '_StockStore.isFilterApplied', context: context);

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

  late final _$isInfoFilterAppliedAtom =
      Atom(name: '_StockStore.isInfoFilterApplied', context: context);

  @override
  bool get isInfoFilterApplied {
    _$isInfoFilterAppliedAtom.reportRead();
    return super.isInfoFilterApplied;
  }

  @override
  set isInfoFilterApplied(bool value) {
    _$isInfoFilterAppliedAtom.reportWrite(value, super.isInfoFilterApplied, () {
      super.isInfoFilterApplied = value;
    });
  }

  late final _$sortKeyAtom =
      Atom(name: '_StockStore.sortKey', context: context);

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
      Atom(name: '_StockStore.totalPages', context: context);

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

  late final _$totalinfoPagesAtom =
      Atom(name: '_StockStore.totalinfoPages', context: context);

  @override
  int get totalinfoPages {
    _$totalinfoPagesAtom.reportRead();
    return super.totalinfoPages;
  }

  @override
  set totalinfoPages(int value) {
    _$totalinfoPagesAtom.reportWrite(value, super.totalinfoPages, () {
      super.totalinfoPages = value;
    });
  }

  late final _$sortAscAtom =
      Atom(name: '_StockStore.sortAsc', context: context);

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
      Atom(name: '_StockStore.searchedText', context: context);

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
      Atom(name: '_StockStore.selectedRowCount', context: context);

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
      Atom(name: '_StockStore.currentTablePage', context: context);

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

  late final _$currentInfoTablePageAtom =
      Atom(name: '_StockStore.currentInfoTablePage', context: context);

  @override
  int get currentInfoTablePage {
    _$currentInfoTablePageAtom.reportRead();
    return super.currentInfoTablePage;
  }

  @override
  set currentInfoTablePage(int value) {
    _$currentInfoTablePageAtom.reportWrite(value, super.currentInfoTablePage,
        () {
      super.currentInfoTablePage = value;
    });
  }

  late final _$selectedFirmAtom =
      Atom(name: '_StockStore.selectedFirm', context: context);

  @override
  String get selectedFirm {
    _$selectedFirmAtom.reportRead();
    return super.selectedFirm;
  }

  @override
  set selectedFirm(String value) {
    _$selectedFirmAtom.reportWrite(value, super.selectedFirm, () {
      super.selectedFirm = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_StockStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_StockStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$addStockItemAsyncAction =
      AsyncAction('_StockStore.addStockItem', context: context);

  @override
  Future<void> addStockItem(StockItem stock) {
    return _$addStockItemAsyncAction.run(() => super.addStockItem(stock));
  }

  late final _$updateStockItemAsyncAction =
      AsyncAction('_StockStore.updateStockItem', context: context);

  @override
  Future<void> updateStockItem(StockItem stock) {
    return _$updateStockItemAsyncAction.run(() => super.updateStockItem(stock));
  }

  late final _$deleteStockItemAsyncAction =
      AsyncAction('_StockStore.deleteStockItem', context: context);

  @override
  Future<void> deleteStockItem(String id) {
    return _$deleteStockItemAsyncAction.run(() => super.deleteStockItem(id));
  }

  late final _$_StockStoreActionController =
      ActionController(name: '_StockStore', context: context);

  @override
  void setSelectedTransType(dynamic value) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setSelectedTransType');
    try {
      return super.setSelectedTransType(value);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTransStatus(dynamic value) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setSelectedTransStatus');
    try {
      return super.setSelectedTransStatus(value);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFilterTransactionType(TransactionTypeEnum value) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setSelectedFilterTransactionType');
    try {
      return super.setSelectedFilterTransactionType(value);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStockItemList(List<StockItem> stockList) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setStockItemList');
    try {
      return super.setStockItemList(stockList);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLedgerList(List<StockPartyLedger> ledgerListValue) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setLedgerList');
    try {
      return super.setLedgerList(ledgerListValue);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedProduct(StockItem? stock) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setSelectedProduct');
    try {
      return super.setSelectedProduct(stock);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFirm(String firm) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setSelectedFirm');
    try {
      return super.setSelectedFirm(firm);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isFiltersApplied() {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.isFiltersApplied');
    try {
      return super.isFiltersApplied();
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isInfoFilterAppliedCheck() {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.isInfoFilterAppliedCheck');
    try {
      return super.isInfoFilterAppliedCheck();
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateInfoTotalPages() {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.calculateInfoTotalPages');
    try {
      return super.calculateInfoTotalPages();
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterLedgerList() {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.filterLedgerList');
    try {
      return super.filterLedgerList();
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllFilters() {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.clearAllFilters');
    try {
      return super.clearAllFilters();
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearInfoFilter() {
    final _$actionInfo = _$_StockStoreActionController.startAction(
        name: '_StockStore.clearInfoFilter');
    try {
      return super.clearInfoFilter();
    } finally {
      _$_StockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stockItemList: ${stockItemList},
ledgerList: ${ledgerList},
selectedStockItem: ${selectedStockItem},
selectedTransType: ${selectedTransType},
selectedTransStatus: ${selectedTransStatus},
selectedFilterTransactionType: ${selectedFilterTransactionType},
showItemInfo: ${showItemInfo},
isFilterApplied: ${isFilterApplied},
isInfoFilterApplied: ${isInfoFilterApplied},
sortKey: ${sortKey},
totalPages: ${totalPages},
totalinfoPages: ${totalinfoPages},
sortAsc: ${sortAsc},
searchedText: ${searchedText},
selectedRowCount: ${selectedRowCount},
currentTablePage: ${currentTablePage},
currentInfoTablePage: ${currentInfoTablePage},
selectedFirm: ${selectedFirm},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
paginatedData: ${paginatedData},
paginatedInfoData: ${paginatedInfoData},
sortedData: ${sortedData},
filteredData: ${filteredData},
filteredInfoData: ${filteredInfoData}
    ''';
  }
}
