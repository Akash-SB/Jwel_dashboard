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

  late final _$partyIdsAtom =
      Atom(name: '_PurchaseScreenStore.partyIds', context: context);

  @override
  List<String> get partyIds {
    _$partyIdsAtom.reportRead();
    return super.partyIds;
  }

  @override
  set partyIds(List<String> value) {
    _$partyIdsAtom.reportWrite(value, super.partyIds, () {
      super.partyIds = value;
    });
  }

  late final _$selectedFilterFirmAtom =
      Atom(name: '_PurchaseScreenStore.selectedFilterFirm', context: context);

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

  late final _$showLoadersAtom =
      Atom(name: '_PurchaseScreenStore.showLoaders', context: context);

  @override
  Observable<bool> get showLoaders {
    _$showLoadersAtom.reportRead();
    return super.showLoaders;
  }

  @override
  set showLoaders(Observable<bool> value) {
    _$showLoadersAtom.reportWrite(value, super.showLoaders, () {
      super.showLoaders = value;
    });
  }

  late final _$selectedPartyTypeAtom =
      Atom(name: '_PurchaseScreenStore.selectedPartyType', context: context);

  @override
  String get selectedPartyType {
    _$selectedPartyTypeAtom.reportRead();
    return super.selectedPartyType;
  }

  @override
  set selectedPartyType(String value) {
    _$selectedPartyTypeAtom.reportWrite(value, super.selectedPartyType, () {
      super.selectedPartyType = value;
    });
  }

  late final _$salectedStatusAtom =
      Atom(name: '_PurchaseScreenStore.salectedStatus', context: context);

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

  late final _$selectedPaymentTypeAtom =
      Atom(name: '_PurchaseScreenStore.selectedPaymentType', context: context);

  @override
  String? get selectedPaymentType {
    _$selectedPaymentTypeAtom.reportRead();
    return super.selectedPaymentType;
  }

  @override
  set selectedPaymentType(String? value) {
    _$selectedPaymentTypeAtom.reportWrite(value, super.selectedPaymentType, () {
      super.selectedPaymentType = value;
    });
  }

  late final _$isFilterAppliedAtom =
      Atom(name: '_PurchaseScreenStore.isFilterApplied', context: context);

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

  late final _$selectedPaymentStatusAtom = Atom(
      name: '_PurchaseScreenStore.selectedPaymentStatus', context: context);

  @override
  String get selectedPaymentStatus {
    _$selectedPaymentStatusAtom.reportRead();
    return super.selectedPaymentStatus;
  }

  @override
  set selectedPaymentStatus(String value) {
    _$selectedPaymentStatusAtom.reportWrite(value, super.selectedPaymentStatus,
        () {
      super.selectedPaymentStatus = value;
    });
  }

  late final _$selectedStockItemAtom =
      Atom(name: '_PurchaseScreenStore.selectedStockItem', context: context);

  @override
  StockItem? get selectedStockItem {
    _$selectedStockItemAtom.reportRead();
    return super.selectedStockItem;
  }

  @override
  set selectedStockItem(StockItem? value) {
    _$selectedStockItemAtom.reportWrite(value, super.selectedStockItem, () {
      super.selectedStockItem = value;
    });
  }

  late final _$selectedFirmTypeAtom =
      Atom(name: '_PurchaseScreenStore.selectedFirmType', context: context);

  @override
  String get selectedFirmType {
    _$selectedFirmTypeAtom.reportRead();
    return super.selectedFirmType;
  }

  @override
  set selectedFirmType(String value) {
    _$selectedFirmTypeAtom.reportWrite(value, super.selectedFirmType, () {
      super.selectedFirmType = value;
    });
  }

  late final _$itemSelectionTypeAtom =
      Atom(name: '_PurchaseScreenStore.itemSelectionType', context: context);

  @override
  String get itemSelectionType {
    _$itemSelectionTypeAtom.reportRead();
    return super.itemSelectionType;
  }

  @override
  set itemSelectionType(String value) {
    _$itemSelectionTypeAtom.reportWrite(value, super.itemSelectionType, () {
      super.itemSelectionType = value;
    });
  }

  late final _$selectedPartyAtom =
      Atom(name: '_PurchaseScreenStore.selectedParty', context: context);

  @override
  Party? get selectedParty {
    _$selectedPartyAtom.reportRead();
    return super.selectedParty;
  }

  @override
  set selectedParty(Party? value) {
    _$selectedPartyAtom.reportWrite(value, super.selectedParty, () {
      super.selectedParty = value;
    });
  }

  late final _$agentDetailsAtom =
      Atom(name: '_PurchaseScreenStore.agentDetails', context: context);

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
      Atom(name: '_PurchaseScreenStore.isAgentSelected', context: context);

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

  late final _$agentTypeAtom =
      Atom(name: '_PurchaseScreenStore.agentType', context: context);

  @override
  String get agentType {
    _$agentTypeAtom.reportRead();
    return super.agentType;
  }

  @override
  set agentType(String value) {
    _$agentTypeAtom.reportWrite(value, super.agentType, () {
      super.agentType = value;
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

  late final _$selectedAgentDetailsAtom =
      Atom(name: '_PurchaseScreenStore.selectedAgentDetails', context: context);

  @override
  Party? get selectedAgentDetails {
    _$selectedAgentDetailsAtom.reportRead();
    return super.selectedAgentDetails;
  }

  @override
  set selectedAgentDetails(Party? value) {
    _$selectedAgentDetailsAtom.reportWrite(value, super.selectedAgentDetails,
        () {
      super.selectedAgentDetails = value;
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

  late final _$addPartyDetailsAsyncAction =
      AsyncAction('_PurchaseScreenStore.addPartyDetails', context: context);

  @override
  Future<void> addPartyDetails(Party party) {
    return _$addPartyDetailsAsyncAction.run(() => super.addPartyDetails(party));
  }

  late final _$addPurchaseAsyncAction =
      AsyncAction('_PurchaseScreenStore.addPurchase', context: context);

  @override
  Future<void> addPurchase(Purchase purchase) {
    return _$addPurchaseAsyncAction.run(() => super.addPurchase(purchase));
  }

  late final _$addStockItemAsyncAction =
      AsyncAction('_PurchaseScreenStore.addStockItem', context: context);

  @override
  Future<void> addStockItem(StockItem stock) {
    return _$addStockItemAsyncAction.run(() => super.addStockItem(stock));
  }

  late final _$updateStockItemAsyncAction =
      AsyncAction('_PurchaseScreenStore.updateStockItem', context: context);

  @override
  Future<void> updateStockItem(StockItem stock) {
    return _$updateStockItemAsyncAction.run(() => super.updateStockItem(stock));
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
  void setShowLoader(bool value) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setShowLoader');
    try {
      return super.setShowLoader(value);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStatus(String value) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSelectedStatus');
    try {
      return super.setSelectedStatus(value);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPartyIds(List<String> list) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setPartyIds');
    try {
      return super.setPartyIds(list);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStockItem(StockItem? item) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSelectedStockItem');
    try {
      return super.setSelectedStockItem(item);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPaymentType(String? type) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSelectedPaymentType');
    try {
      return super.setSelectedPaymentType(type);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPaymentStatus(String? status) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSelectedPaymentStatus');
    try {
      return super.setSelectedPaymentStatus(status);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFilterFirm(String firm) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSelectedFilterFirm');
    try {
      return super.setSelectedFilterFirm(firm);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isFiltersApplied() {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.isFiltersApplied');
    try {
      return super.isFiltersApplied();
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String? message) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setErrorMessage');
    try {
      return super.setErrorMessage(message);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsAgentSelected(bool value) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setIsAgentSelected');
    try {
      return super.setIsAgentSelected(value);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgentType(String type) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setAgentType');
    try {
      return super.setAgentType(type);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgentDetails(Party agent) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setAgentDetails');
    try {
      return super.setAgentDetails(agent);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgentInfoDetails(Party? agentDetails) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setAgentInfoDetails');
    try {
      return super.setAgentInfoDetails(agentDetails);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setselectedParty(Party? party) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setselectedParty');
    try {
      return super.setselectedParty(party);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setItemSelectionType(String type) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setItemSelectionType');
    try {
      return super.setItemSelectionType(type);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFirm(String firm) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSelectedFirm');
    try {
      return super.setSelectedFirm(firm);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPartyType(String type) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setSelectedPartyType');
    try {
      return super.setSelectedPartyType(type);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPartyIds() {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.getPartyIds');
    try {
      return super.getPartyIds();
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Party? getPartyById(String partyId) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.getPartyById');
    try {
      return super.getPartyById(partyId);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStockList(List<StockItem> list) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setStockList');
    try {
      return super.setStockList(list);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

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
  void setPartiesList(List<Party> list) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setPartiesList');
    try {
      return super.setPartiesList(list);
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
  void setPurchaseList(List<Purchase> list) {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.setPurchaseList');
    try {
      return super.setPurchaseList(list);
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllFilters() {
    final _$actionInfo = _$_PurchaseScreenStoreActionController.startAction(
        name: '_PurchaseScreenStore.clearAllFilters');
    try {
      return super.clearAllFilters();
    } finally {
      _$_PurchaseScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
stockList: ${stockList},
partyIds: ${partyIds},
selectedFilterFirm: ${selectedFilterFirm},
showLoaders: ${showLoaders},
selectedPartyType: ${selectedPartyType},
salectedStatus: ${salectedStatus},
selectedPaymentType: ${selectedPaymentType},
isFilterApplied: ${isFilterApplied},
selectedPaymentStatus: ${selectedPaymentStatus},
selectedStockItem: ${selectedStockItem},
selectedFirmType: ${selectedFirmType},
itemSelectionType: ${itemSelectionType},
selectedParty: ${selectedParty},
agentDetails: ${agentDetails},
isAgentSelected: ${isAgentSelected},
agentType: ${agentType},
errorMessage: ${errorMessage},
selectedAgentDetails: ${selectedAgentDetails},
sortKey: ${sortKey},
totalPages: ${totalPages},
sortAsc: ${sortAsc},
searchedText: ${searchedText},
selectedRowCount: ${selectedRowCount},
currentTablePage: ${currentTablePage},
partiesList: ${partiesList},
purchases: ${purchases},
isLoading: ${isLoading},
paginatedData: ${paginatedData},
sortedData: ${sortedData},
filteredData: ${filteredData}
    ''';
  }
}
