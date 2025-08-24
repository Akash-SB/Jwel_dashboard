// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SalesScreenStore on _SalesScreenStore, Store {
  Computed<List<Sale>>? _$paginatedDataComputed;

  @override
  List<Sale> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<Sale>>(() => super.paginatedData,
              name: '_SalesScreenStore.paginatedData'))
      .value;
  Computed<List<Sale>>? _$sortedDataComputed;

  @override
  List<Sale> get sortedData =>
      (_$sortedDataComputed ??= Computed<List<Sale>>(() => super.sortedData,
              name: '_SalesScreenStore.sortedData'))
          .value;
  Computed<List<Sale>>? _$filteredDataComputed;

  @override
  List<Sale> get filteredData =>
      (_$filteredDataComputed ??= Computed<List<Sale>>(() => super.filteredData,
              name: '_SalesScreenStore.filteredData'))
          .value;

  late final _$salesAtom =
      Atom(name: '_SalesScreenStore.sales', context: context);

  @override
  ObservableList<Sale> get sales {
    _$salesAtom.reportRead();
    return super.sales;
  }

  @override
  set sales(ObservableList<Sale> value) {
    _$salesAtom.reportWrite(value, super.sales, () {
      super.sales = value;
    });
  }

  late final _$stocksAtom =
      Atom(name: '_SalesScreenStore.stocks', context: context);

  @override
  ObservableList<StockItem> get stocks {
    _$stocksAtom.reportRead();
    return super.stocks;
  }

  @override
  set stocks(ObservableList<StockItem> value) {
    _$stocksAtom.reportWrite(value, super.stocks, () {
      super.stocks = value;
    });
  }

  late final _$partiesListAtom =
      Atom(name: '_SalesScreenStore.partiesList', context: context);

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

  late final _$selectedPartyAtom =
      Atom(name: '_SalesScreenStore.selectedParty', context: context);

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

  late final _$selectedItemAtom =
      Atom(name: '_SalesScreenStore.selectedItem', context: context);

  @override
  Observable<StockItem>? get selectedItem {
    _$selectedItemAtom.reportRead();
    return super.selectedItem;
  }

  @override
  set selectedItem(Observable<StockItem>? value) {
    _$selectedItemAtom.reportWrite(value, super.selectedItem, () {
      super.selectedItem = value;
    });
  }

  late final _$selectedFilterFirmAtom =
      Atom(name: '_SalesScreenStore.selectedFilterFirm', context: context);

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

  late final _$salectedStatusAtom =
      Atom(name: '_SalesScreenStore.salectedStatus', context: context);

  @override
  String get salectedStatus {
    _$salectedStatusAtom.reportRead();
    return super.salectedStatus;
  }

  @override
  set salectedStatus(String value) {
    _$salectedStatusAtom.reportWrite(value, super.salectedStatus, () {
      super.salectedStatus = value;
    });
  }

  late final _$sortKeyAtom =
      Atom(name: '_SalesScreenStore.sortKey', context: context);

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
      Atom(name: '_SalesScreenStore.totalPages', context: context);

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
      Atom(name: '_SalesScreenStore.sortAsc', context: context);

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

  late final _$customerTypeAtom =
      Atom(name: '_SalesScreenStore.customerType', context: context);

  @override
  String get customerType {
    _$customerTypeAtom.reportRead();
    return super.customerType;
  }

  @override
  set customerType(String value) {
    _$customerTypeAtom.reportWrite(value, super.customerType, () {
      super.customerType = value;
    });
  }

  late final _$isFilterAppliedAtom =
      Atom(name: '_SalesScreenStore.isFilterApplied', context: context);

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

  late final _$agentDetailsAtom =
      Atom(name: '_SalesScreenStore.agentDetails', context: context);

  @override
  Observable<Party>? get agentDetails {
    _$agentDetailsAtom.reportRead();
    return super.agentDetails;
  }

  @override
  set agentDetails(Observable<Party>? value) {
    _$agentDetailsAtom.reportWrite(value, super.agentDetails, () {
      super.agentDetails = value;
    });
  }

  late final _$isAgentSelectedAtom =
      Atom(name: '_SalesScreenStore.isAgentSelected', context: context);

  @override
  bool get isAgentSelected {
    _$isAgentSelectedAtom.reportRead();
    return super.isAgentSelected;
  }

  @override
  set isAgentSelected(bool value) {
    _$isAgentSelectedAtom.reportWrite(value, super.isAgentSelected, () {
      super.isAgentSelected = value;
    });
  }

  late final _$searchedTextAtom =
      Atom(name: '_SalesScreenStore.searchedText', context: context);

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
      Atom(name: '_SalesScreenStore.selectedRowCount', context: context);

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
      Atom(name: '_SalesScreenStore.currentTablePage', context: context);

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
      Atom(name: '_SalesScreenStore.isLoading', context: context);

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
      Atom(name: '_SalesScreenStore.errorMessage', context: context);

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

  late final _$fetchSalesAsyncAction =
      AsyncAction('_SalesScreenStore.fetchSales', context: context);

  @override
  Future<void> fetchSales() {
    return _$fetchSalesAsyncAction.run(() => super.fetchSales());
  }

  late final _$addSaleAsyncAction =
      AsyncAction('_SalesScreenStore.addSale', context: context);

  @override
  Future<void> addSale(Sale sale) {
    return _$addSaleAsyncAction.run(() => super.addSale(sale));
  }

  late final _$updateSaleAsyncAction =
      AsyncAction('_SalesScreenStore.updateSale', context: context);

  @override
  Future<void> updateSale(Sale sale) {
    return _$updateSaleAsyncAction.run(() => super.updateSale(sale));
  }

  late final _$deleteSaleAsyncAction =
      AsyncAction('_SalesScreenStore.deleteSale', context: context);

  @override
  Future<void> deleteSale(String id) {
    return _$deleteSaleAsyncAction.run(() => super.deleteSale(id));
  }

  late final _$_SalesScreenStoreActionController =
      ActionController(name: '_SalesScreenStore', context: context);

  @override
  void setIsAgentSelected(bool value) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setIsAgentSelected');
    try {
      return super.setIsAgentSelected(value);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStatus(String value) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setSelectedStatus');
    try {
      return super.setSelectedStatus(value);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFilterFirm(String firm) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setSelectedFilterFirm');
    try {
      return super.setSelectedFilterFirm(firm);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isFiltersApplied() {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.isFiltersApplied');
    try {
      return super.isFiltersApplied();
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCustomerType(String type) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setCustomerType');
    try {
      return super.setCustomerType(type);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgentDetails(Party agent) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setAgentDetails');
    try {
      return super.setAgentDetails(agent);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllFilters() {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.clearAllFilters');
    try {
      return super.clearAllFilters();
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedParty(Party party) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setSelectedParty');
    try {
      return super.setSelectedParty(party);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStock(StockItem stock) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setSelectedStock');
    try {
      return super.setSelectedStock(stock);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSalesList(List<Sale> salesList) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setSalesList');
    try {
      return super.setSalesList(salesList);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStockList(List<StockItem> stockList) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setStockList');
    try {
      return super.setStockList(stockList);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPartiesList(List<Party> partyList) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setPartiesList');
    try {
      return super.setPartiesList(partyList);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String? message) {
    final _$actionInfo = _$_SalesScreenStoreActionController.startAction(
        name: '_SalesScreenStore.setErrorMessage');
    try {
      return super.setErrorMessage(message);
    } finally {
      _$_SalesScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sales: ${sales},
stocks: ${stocks},
partiesList: ${partiesList},
selectedParty: ${selectedParty},
selectedItem: ${selectedItem},
selectedFilterFirm: ${selectedFilterFirm},
salectedStatus: ${salectedStatus},
sortKey: ${sortKey},
totalPages: ${totalPages},
sortAsc: ${sortAsc},
customerType: ${customerType},
isFilterApplied: ${isFilterApplied},
agentDetails: ${agentDetails},
isAgentSelected: ${isAgentSelected},
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
