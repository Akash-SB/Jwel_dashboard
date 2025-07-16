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

  late final _$sixMonthTxnListAtom =
      Atom(name: '_UserDataStore.sixMonthTxnList', context: context);

  @override
  ObservableList<InvoiceModel> get sixMonthTxnList {
    _$sixMonthTxnListAtom.reportRead();
    return super.sixMonthTxnList;
  }

  @override
  set sixMonthTxnList(ObservableList<InvoiceModel> value) {
    _$sixMonthTxnListAtom.reportWrite(value, super.sixMonthTxnList, () {
      super.sixMonthTxnList = value;
    });
  }

  late final _$customersAtom =
      Atom(name: '_UserDataStore.customers', context: context);

  @override
  ObservableList<CustomerModel> get customers {
    _$customersAtom.reportRead();
    return super.customers;
  }

  @override
  set customers(ObservableList<CustomerModel> value) {
    _$customersAtom.reportWrite(value, super.customers, () {
      super.customers = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_UserDataStore.products', context: context);

  @override
  ObservableList<ProductModel> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ProductModel> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$fetchCustomersAsyncAction =
      AsyncAction('_UserDataStore.fetchCustomers', context: context);

  @override
  Future<void> fetchCustomers() {
    return _$fetchCustomersAsyncAction.run(() => super.fetchCustomers());
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('_UserDataStore.fetchProducts', context: context);

  @override
  Future<void> fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  late final _$fetchInvoicesAsyncAction =
      AsyncAction('_UserDataStore.fetchInvoices', context: context);

  @override
  Future<void> fetchInvoices() {
    return _$fetchInvoicesAsyncAction.run(() => super.fetchInvoices());
  }

  late final _$_UserDataStoreActionController =
      ActionController(name: '_UserDataStore', context: context);

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
  void getLastSixMonthsTxns(List<InvoiceModel> allInvoices) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.getLastSixMonthsTxns');
    try {
      return super.getLastSixMonthsTxns(allInvoices);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSixMonthTxn(List<InvoiceModel> invoiceList) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setSixMonthTxn');
    try {
      return super.setSixMonthTxn(invoiceList);
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
  void setCustomers(List<CustomerModel> customerList) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setCustomers');
    try {
      return super.setCustomers(customerList);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProducts(List<ProductModel> productList) {
    final _$actionInfo = _$_UserDataStoreActionController.startAction(
        name: '_UserDataStore.setProducts');
    try {
      return super.setProducts(productList);
    } finally {
      _$_UserDataStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
tabIndex: ${tabIndex},
invoices: ${invoices},
sixMonthTxnList: ${sixMonthTxnList},
customers: ${customers},
products: ${products}
    ''';
  }
}
