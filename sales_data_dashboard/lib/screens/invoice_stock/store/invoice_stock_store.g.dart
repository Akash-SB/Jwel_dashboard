// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_stock_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InvoiceStockStore on _InvoiceStockStore, Store {
  Computed<List<InvoiceStockModel>>? _$paginatedDataComputed;

  @override
  List<InvoiceStockModel> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<InvoiceStockModel>>(() => super.paginatedData,
              name: '_InvoiceStockStore.paginatedData'))
      .value;
  Computed<List<InvoiceStockModel>>? _$filteredDataComputed;

  @override
  List<InvoiceStockModel> get filteredData => (_$filteredDataComputed ??=
          Computed<List<InvoiceStockModel>>(() => super.filteredData,
              name: '_InvoiceStockStore.filteredData'))
      .value;

  late final _$showItemInfoAtom =
      Atom(name: '_InvoiceStockStore.showItemInfo', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_InvoiceStockStore.isLoading', context: context);

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

  late final _$searchedTextAtom =
      Atom(name: '_InvoiceStockStore.searchedText', context: context);

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

  late final _$currentTablePageAtom =
      Atom(name: '_InvoiceStockStore.currentTablePage', context: context);

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

  late final _$isFilterAppliedAtom =
      Atom(name: '_InvoiceStockStore.isFilterApplied', context: context);

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

  late final _$selectedRowCountAtom =
      Atom(name: '_InvoiceStockStore.selectedRowCount', context: context);

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

  late final _$totalPagesAtom =
      Atom(name: '_InvoiceStockStore.totalPages', context: context);

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

  late final _$stockListAtom =
      Atom(name: '_InvoiceStockStore.stockList', context: context);

  @override
  ObservableList<InvoiceStockModel> get stockList {
    _$stockListAtom.reportRead();
    return super.stockList;
  }

  @override
  set stockList(ObservableList<InvoiceStockModel> value) {
    _$stockListAtom.reportWrite(value, super.stockList, () {
      super.stockList = value;
    });
  }

  late final _$selectedStockAtom =
      Atom(name: '_InvoiceStockStore.selectedStock', context: context);

  @override
  InvoiceStockModel? get selectedStock {
    _$selectedStockAtom.reportRead();
    return super.selectedStock;
  }

  @override
  set selectedStock(InvoiceStockModel? value) {
    _$selectedStockAtom.reportWrite(value, super.selectedStock, () {
      super.selectedStock = value;
    });
  }

  late final _$selectedFirmAtom =
      Atom(name: '_InvoiceStockStore.selectedFirm', context: context);

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

  late final _$fetchStockItemsAsyncAction =
      AsyncAction('_InvoiceStockStore.fetchStockItems', context: context);

  @override
  Future<void> fetchStockItems() {
    return _$fetchStockItemsAsyncAction.run(() => super.fetchStockItems());
  }

  late final _$addStockItemAsyncAction =
      AsyncAction('_InvoiceStockStore.addStockItem', context: context);

  @override
  Future<void> addStockItem(InvoiceStockModel item) {
    return _$addStockItemAsyncAction.run(() => super.addStockItem(item));
  }

  late final _$updateStockItemAsyncAction =
      AsyncAction('_InvoiceStockStore.updateStockItem', context: context);

  @override
  Future<void> updateStockItem(InvoiceStockModel item) {
    return _$updateStockItemAsyncAction.run(() => super.updateStockItem(item));
  }

  late final _$deleteStockItemAsyncAction =
      AsyncAction('_InvoiceStockStore.deleteStockItem', context: context);

  @override
  Future<void> deleteStockItem(InvoiceStockModel item) {
    return _$deleteStockItemAsyncAction.run(() => super.deleteStockItem(item));
  }

  late final _$_InvoiceStockStoreActionController =
      ActionController(name: '_InvoiceStockStore', context: context);

  @override
  void setSelectedFirm(String value) {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.setSelectedFirm');
    try {
      return super.setSelectedFirm(value);
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStockList(List<InvoiceStockModel> list) {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.setStockList');
    try {
      return super.setStockList(list);
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStockItem(InvoiceStockModel item) {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.setSelectedStockItem');
    try {
      return super.setSelectedStockItem(item);
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isFiltersApplied() {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.isFiltersApplied');
    try {
      return super.isFiltersApplied();
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllFilters() {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.clearAllFilters');
    try {
      return super.clearAllFilters();
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInvoiceStockList(List<InvoiceStockModel> stockItems) {
    final _$actionInfo = _$_InvoiceStockStoreActionController.startAction(
        name: '_InvoiceStockStore.setInvoiceStockList');
    try {
      return super.setInvoiceStockList(stockItems);
    } finally {
      _$_InvoiceStockStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showItemInfo: ${showItemInfo},
isLoading: ${isLoading},
searchedText: ${searchedText},
currentTablePage: ${currentTablePage},
isFilterApplied: ${isFilterApplied},
selectedRowCount: ${selectedRowCount},
totalPages: ${totalPages},
stockList: ${stockList},
selectedStock: ${selectedStock},
selectedFirm: ${selectedFirm},
paginatedData: ${paginatedData},
filteredData: ${filteredData}
    ''';
  }
}
