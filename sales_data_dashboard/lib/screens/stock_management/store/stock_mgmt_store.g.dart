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

  late final _$fetchStockListAsyncAction =
      AsyncAction('_StockStore.fetchStockList', context: context);

  @override
  Future<void> fetchStockList() {
    return _$fetchStockListAsyncAction.run(() => super.fetchStockList());
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
  String toString() {
    return '''
stockItemList: ${stockItemList},
selectedStockItem: ${selectedStockItem},
sortKey: ${sortKey},
totalPages: ${totalPages},
sortAsc: ${sortAsc},
searchedText: ${searchedText},
selectedRowCount: ${selectedRowCount},
currentTablePage: ${currentTablePage},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
paginatedData: ${paginatedData},
sortedData: ${sortedData},
filteredData: ${filteredData}
    ''';
  }
}
