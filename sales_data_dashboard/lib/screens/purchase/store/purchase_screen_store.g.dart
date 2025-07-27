// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PurchaseScreenStore on _PurchaseScreenStore, Store {
  Computed<List<Purchase>>? _$paginatedDataComputed;

  @override
  List<Purchase> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<Purchase>>(() => super.paginatedData,
              name: '_PurchaseScreenStore.paginatedData'))
      .value;
  Computed<List<Purchase>>? _$sortedDataComputed;

  @override
  List<Purchase> get sortedData =>
      (_$sortedDataComputed ??= Computed<List<Purchase>>(() => super.sortedData,
              name: '_PurchaseScreenStore.sortedData'))
          .value;
  Computed<List<Purchase>>? _$filteredDataComputed;

  @override
  List<Purchase> get filteredData => (_$filteredDataComputed ??=
          Computed<List<Purchase>>(() => super.filteredData,
              name: '_PurchaseScreenStore.filteredData'))
      .value;

  late final _$purchaseListAtom =
      Atom(name: '_PurchaseScreenStore.purchaseList', context: context);

  @override
  ObservableList<Purchase> get purchaseList {
    _$purchaseListAtom.reportRead();
    return super.purchaseList;
  }

  @override
  set purchaseList(ObservableList<Purchase> value) {
    _$purchaseListAtom.reportWrite(value, super.purchaseList, () {
      super.purchaseList = value;
    });
  }

  late final _$stockListAtom =
      Atom(name: '_PurchaseScreenStore.stockList', context: context);

  @override
  ObservableList<StockItem> get stockList {
    _$stockListAtom.reportRead();
    return super.stockList;
  }

  @override
  set stockList(ObservableList<StockItem> value) {
    _$stockListAtom.reportWrite(value, super.stockList, () {
      super.stockList = value;
    });
  }

  late final _$sortKeyAtom =
      Atom(name: '_PurchaseScreenStore.sortKey', context: context);

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
      Atom(name: '_PurchaseScreenStore.totalPages', context: context);

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
      Atom(name: '_PurchaseScreenStore.sortAsc', context: context);

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
      Atom(name: '_PurchaseScreenStore.searchedText', context: context);

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
      Atom(name: '_PurchaseScreenStore.selectedRowCount', context: context);

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
      Atom(name: '_PurchaseScreenStore.currentTablePage', context: context);

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

  late final _$partiesListAtom =
      Atom(name: '_PurchaseScreenStore.partiesList', context: context);

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

  late final _$purchasesAtom =
      Atom(name: '_PurchaseScreenStore.purchases', context: context);

  @override
  ObservableList<Purchase> get purchases {
    _$purchasesAtom.reportRead();
    return super.purchases;
  }

  @override
  set purchases(ObservableList<Purchase> value) {
    _$purchasesAtom.reportWrite(value, super.purchases, () {
      super.purchases = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PurchaseScreenStore.isLoading', context: context);

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
      Atom(name: '_PurchaseScreenStore.errorMessage', context: context);

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

  late final _$initDbAsyncAction =
      AsyncAction('_PurchaseScreenStore.initDb', context: context);

  @override
  Future<void> initDb() {
    return _$initDbAsyncAction.run(() => super.initDb());
  }

  late final _$addInStockAsyncAction =
      AsyncAction('_PurchaseScreenStore.addInStock', context: context);

  @override
  Future<void> addInStock(StockItem item) {
    return _$addInStockAsyncAction.run(() => super.addInStock(item));
  }

  late final _$fetchStockItemAsyncAction =
      AsyncAction('_PurchaseScreenStore.fetchStockItem', context: context);

  @override
  Future<void> fetchStockItem() {
    return _$fetchStockItemAsyncAction.run(() => super.fetchStockItem());
  }

  late final _$fetchPurchasesAsyncAction =
      AsyncAction('_PurchaseScreenStore.fetchPurchases', context: context);

  @override
  Future<void> fetchPurchases() {
    return _$fetchPurchasesAsyncAction.run(() => super.fetchPurchases());
  }

  late final _$addPurchaseAsyncAction =
      AsyncAction('_PurchaseScreenStore.addPurchase', context: context);

  @override
  Future<void> addPurchase(Purchase purchase) {
    return _$addPurchaseAsyncAction.run(() => super.addPurchase(purchase));
  }

  late final _$updatePurchaseAsyncAction =
      AsyncAction('_PurchaseScreenStore.updatePurchase', context: context);

  @override
  Future<void> updatePurchase(Purchase purchase) {
    return _$updatePurchaseAsyncAction
        .run(() => super.updatePurchase(purchase));
  }

  late final _$deletePurchaseAsyncAction =
      AsyncAction('_PurchaseScreenStore.deletePurchase', context: context);

  @override
  Future<void> deletePurchase(String id) {
    return _$deletePurchaseAsyncAction.run(() => super.deletePurchase(id));
  }

  late final _$_PurchaseScreenStoreActionController =
      ActionController(name: '_PurchaseScreenStore', context: context);

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
purchaseList: ${purchaseList},
stockList: ${stockList},
sortKey: ${sortKey},
totalPages: ${totalPages},
sortAsc: ${sortAsc},
searchedText: ${searchedText},
selectedRowCount: ${selectedRowCount},
currentTablePage: ${currentTablePage},
partiesList: ${partiesList},
purchases: ${purchases},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
paginatedData: ${paginatedData},
sortedData: ${sortedData},
filteredData: ${filteredData}
    ''';
  }
}
