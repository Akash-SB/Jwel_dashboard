// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserDataStore on _UserDataStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_UserDataStore.isLoading', context: context);

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

  late final _$isAllDataLoadedAtom =
      Atom(name: '_UserDataStore.isAllDataLoaded', context: context);

  @override
  Observable<bool> get isAllDataLoaded {
    _$isAllDataLoadedAtom.reportRead();
    return super.isAllDataLoaded;
  }

  @override
  set isAllDataLoaded(Observable<bool> value) {
    _$isAllDataLoadedAtom.reportWrite(value, super.isAllDataLoaded, () {
      super.isAllDataLoaded = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_UserDataStore.errorMessage', context: context);

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

  late final _$tabIndexAtom =
      Atom(name: '_UserDataStore.tabIndex', context: context);

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  late final _$sidebarItemsAtom =
      Atom(name: '_UserDataStore.sidebarItems', context: context);

  @override
  List<SidebarItem> get sidebarItems {
    _$sidebarItemsAtom.reportRead();
    return super.sidebarItems;
  }

  @override
  set sidebarItems(List<SidebarItem> value) {
    _$sidebarItemsAtom.reportWrite(value, super.sidebarItems, () {
      super.sidebarItems = value;
    });
  }

  late final _$invoicesAtom =
      Atom(name: '_UserDataStore.invoices', context: context);

  @override
  ObservableList<InvoiceModel> get invoices {
    _$invoicesAtom.reportRead();
    return super.invoices;
  }

  @override
  set invoices(ObservableList<InvoiceModel> value) {
    _$invoicesAtom.reportWrite(value, super.invoices, () {
      super.invoices = value;
    });
  }

  late final _$sixMonthSalesListAtom =
      Atom(name: '_UserDataStore.sixMonthSalesList', context: context);

  @override
  ObservableList<Sale> get sixMonthSalesList {
    _$sixMonthSalesListAtom.reportRead();
    return super.sixMonthSalesList;
  }

  @override
  set sixMonthSalesList(ObservableList<Sale> value) {
    _$sixMonthSalesListAtom.reportWrite(value, super.sixMonthSalesList, () {
      super.sixMonthSalesList = value;
    });
  }

  late final _$sixMonthPurchaseListAtom =
      Atom(name: '_UserDataStore.sixMonthPurchaseList', context: context);

  @override
  ObservableList<Purchase> get sixMonthPurchaseList {
    _$sixMonthPurchaseListAtom.reportRead();
    return super.sixMonthPurchaseList;
  }

  @override
  set sixMonthPurchaseList(ObservableList<Purchase> value) {
    _$sixMonthPurchaseListAtom.reportWrite(value, super.sixMonthPurchaseList,
        () {
      super.sixMonthPurchaseList = value;
    });
  }

  late final _$stockListAtom =
      Atom(name: '_UserDataStore.stockList', context: context);

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

  late final _$salesListAtom =
      Atom(name: '_UserDataStore.salesList', context: context);

  @override
  ObservableList<Sale> get salesList {
    _$salesListAtom.reportRead();
    return super.salesList;
  }

  @override
  set salesList(ObservableList<Sale> value) {
    _$salesListAtom.reportWrite(value, super.salesList, () {
      super.salesList = value;
    });
  }

  late final _$purchaseListAtom =
      Atom(name: '_UserDataStore.purchaseList', context: context);

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

  late final _$partiesListAtom =
      Atom(name: '_UserDataStore.partiesList', context: context);

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

  late final _$notfListAtom =
      Atom(name: '_UserDataStore.notfList', context: context);

  @override
  ObservableList<InvoiceNotificationModel> get notfList {
    _$notfListAtom.reportRead();
    return super.notfList;
  }

  @override
  set notfList(ObservableList<InvoiceNotificationModel> value) {
    _$notfListAtom.reportWrite(value, super.notfList, () {
      super.notfList = value;
    });
  }

  late final _$stockItemListAtom =
      Atom(name: '_UserDataStore.stockItemList', context: context);

  @override
  ObservableList<InvoiceStockModel> get stockItemList {
    _$stockItemListAtom.reportRead();
    return super.stockItemList;
  }

  @override
  set stockItemList(ObservableList<InvoiceStockModel> value) {
    _$stockItemListAtom.reportWrite(value, super.stockItemList, () {
      super.stockItemList = value;
    });
  }

  late final _$paymentListAtom =
      Atom(name: '_UserDataStore.paymentList', context: context);

  @override
  ObservableList<PaymentModel> get paymentList {
    _$paymentListAtom.reportRead();
    return super.paymentList;
  }

  @override
  set paymentList(ObservableList<PaymentModel> value) {
    _$paymentListAtom.reportWrite(value, super.paymentList, () {
      super.paymentList = value;
    });
  }

  late final _$setNotificationListAsyncAction =
      AsyncAction('_UserDataStore.setNotificationList', context: context);

  @override
  Future<void> setNotificationList(List<Sale> salesList) {
    return _$setNotificationListAsyncAction
        .run(() => super.setNotificationList(salesList));
  }

  late final _$setNotificationAsPaidAsyncAction =
      AsyncAction('_UserDataStore.setNotificationAsPaid', context: context);

  @override
  Future<void> setNotificationAsPaid(String id, List<Sale> salesList) {
    return _$setNotificationAsPaidAsyncAction
        .run(() => super.setNotificationAsPaid(id, salesList));
  }

  late final _$fetchInvoicesAsyncAction =
      AsyncAction('_UserDataStore.fetchInvoices', context: context);

  @override
  Future<void> fetchInvoices() {
    return _$fetchInvoicesAsyncAction.run(() => super.fetchInvoices());
  }

  late final _$fetchStockItemListAsyncAction =
      AsyncAction('_UserDataStore.fetchStockItemList', context: context);

  @override
  Future<void> fetchStockItemList() {
    return _$fetchStockItemListAsyncAction
        .run(() => super.fetchStockItemList());
  }

  late final _$fetchStockListAsyncAction =
      AsyncAction('_UserDataStore.fetchStockList', context: context);

  @override
  Future<void> fetchStockList() {
    return _$fetchStockListAsyncAction.run(() => super.fetchStockList());
  }

  late final _$fetchPartyListAsyncAction =
      AsyncAction('_UserDataStore.fetchPartyList', context: context);

  @override
  Future<void> fetchPartyList() {
    return _$fetchPartyListAsyncAction.run(() => super.fetchPartyList());
  }

  late final _$fetchPaymentsAsyncAction =
      AsyncAction('_UserDataStore.fetchPayments', context: context);

  @override
  Future<void> fetchPayments() {
    return _$fetchPaymentsAsyncAction.run(() => super.fetchPayments());
  }

  late final _$fetchSalesListAsyncAction =
      AsyncAction('_UserDataStore.fetchSalesList', context: context);

  @override
  Future<void> fetchSalesList() {
    return _$fetchSalesListAsyncAction.run(() => super.fetchSalesList());
  }

  late final _$fetchPurchaseListAsyncAction =
      AsyncAction('_UserDataStore.fetchPurchaseList', context: context);

  @override
  Future<void> fetchPurchaseList() {
    return _$fetchPurchaseListAsyncAction.run(() => super.fetchPurchaseList());
  }

  late final _$getAllDataAsyncAction =
      AsyncAction('_UserDataStore.getAllData', context: context);

  @override
  Future<void> getAllData() {
    return _$getAllDataAsyncAction.run(() => super.getAllData());
  }

  late final _$updateSalesStatusAsyncAction =
      AsyncAction('_UserDataStore.updateSalesStatus', context: context);

  @override
  Future<void> updateSalesStatus(String salesId) {
    return _$updateSalesStatusAsyncAction
        .run(() => super.updateSalesStatus(salesId));
  }

  late final _$_UserDataStoreActionController =
      ActionController(name: '_UserDataStore', context: context);

  @override
  void setIsAllDataLoaded(bool value) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setIsAllDataLoaded');
    try {
      return super.setIsAllDataLoaded(value);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSidebarItemExpansion(int index) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.toggleSidebarItemExpansion');
    try {
      return super.toggleSidebarItemExpansion(index);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTab(int index) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setTab');
    try {
      return super.setTab(index);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fillNotificationList(List<InvoiceNotificationModel> list) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.fillNotificationList');
    try {
      return super.fillNotificationList(list);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getLastSixMonthsTxns(List<Sale> allSales, List<Purchase> allPurchase) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.getLastSixMonthsTxns');
    try {
      return super.getLastSixMonthsTxns(allSales, allPurchase);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSixMonthSales(List<Sale> salesList) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setSixMonthSales');
    try {
      return super.setSixMonthSales(salesList);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSixMonthPurchase(List<Purchase> purchaseList) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setSixMonthPurchase');
    try {
      return super.setSixMonthPurchase(purchaseList);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInvoices(List<InvoiceModel> invoiceList) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setInvoices');
    try {
      return super.setInvoices(invoiceList);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStockList(List<StockItem> stockItems) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setStockList');
    try {
      return super.setStockList(stockItems);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPartiesList(List<Party> partyList) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setPartiesList');
    try {
      return super.setPartiesList(partyList);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSalesList(List<Sale> sales) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setSalesList');
    try {
      return super.setSalesList(sales);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPurchaseList(List<Purchase> purchases) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setPurchaseList');
    try {
      return super.setPurchaseList(purchases);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInvoiceStockList(List<InvoiceStockModel> stockItems) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setInvoiceStockList');
    try {
      return super.setInvoiceStockList(stockItems);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentList(List<PaymentModel> payments) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setPaymentList');
    try {
      return super.setPaymentList(payments);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isAllDataLoaded: ${isAllDataLoaded},
errorMessage: ${errorMessage},
tabIndex: ${tabIndex},
sidebarItems: ${sidebarItems},
invoices: ${invoices},
sixMonthSalesList: ${sixMonthSalesList},
sixMonthPurchaseList: ${sixMonthPurchaseList},
stockList: ${stockList},
salesList: ${salesList},
purchaseList: ${purchaseList},
partiesList: ${partiesList},
notfList: ${notfList},
stockItemList: ${stockItemList},
paymentList: ${paymentList}
    ''';
  }
}
