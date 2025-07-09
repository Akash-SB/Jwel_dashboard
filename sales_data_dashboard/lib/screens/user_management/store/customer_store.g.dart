// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerStore on _CustomerStore, Store {
  Computed<List<CustomerModel>>? _$filteredDataComputed;

  @override
  List<CustomerModel> get filteredData => (_$filteredDataComputed ??=
          Computed<List<CustomerModel>>(() => super.filteredData,
              name: '_CustomerStore.filteredData'))
      .value;
  Computed<List<CustomerModel>>? _$sortedDataComputed;

  @override
  List<CustomerModel> get sortedData => (_$sortedDataComputed ??=
          Computed<List<CustomerModel>>(() => super.sortedData,
              name: '_CustomerStore.sortedData'))
      .value;
  Computed<List<CustomerModel>>? _$paginatedDataComputed;

  @override
  List<CustomerModel> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<CustomerModel>>(() => super.paginatedData,
              name: '_CustomerStore.paginatedData'))
      .value;

  late final _$customersAtom =
      Atom(name: '_CustomerStore.customers', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_CustomerStore.isLoading', context: context);

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
      Atom(name: '_CustomerStore.errorMessage', context: context);

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

  late final _$searchedTextAtom =
      Atom(name: '_CustomerStore.searchedText', context: context);

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

  late final _$selectedUserTypeAtom =
      Atom(name: '_CustomerStore.selectedUserType', context: context);

  @override
  String get selectedUserType {
    _$selectedUserTypeAtom.reportRead();
    return super.selectedUserType;
  }

  @override
  set selectedUserType(String value) {
    _$selectedUserTypeAtom.reportWrite(value, super.selectedUserType, () {
      super.selectedUserType = value;
    });
  }

  late final _$isFilterAppliedAtom =
      Atom(name: '_CustomerStore.isFilterApplied', context: context);

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

  late final _$currentTablePageAtom =
      Atom(name: '_CustomerStore.currentTablePage', context: context);

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

  late final _$totalPagesAtom =
      Atom(name: '_CustomerStore.totalPages', context: context);

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

  late final _$isToggleAtom =
      Atom(name: '_CustomerStore.isToggle', context: context);

  @override
  bool get isToggle {
    _$isToggleAtom.reportRead();
    return super.isToggle;
  }

  @override
  set isToggle(bool value) {
    _$isToggleAtom.reportWrite(value, super.isToggle, () {
      super.isToggle = value;
    });
  }

  late final _$selectedCustomerAtom =
      Atom(name: '_CustomerStore.selectedCustomer', context: context);

  @override
  CustomerModel? get selectedCustomer {
    _$selectedCustomerAtom.reportRead();
    return super.selectedCustomer;
  }

  @override
  set selectedCustomer(CustomerModel? value) {
    _$selectedCustomerAtom.reportWrite(value, super.selectedCustomer, () {
      super.selectedCustomer = value;
    });
  }

  late final _$sortKeyAtom =
      Atom(name: '_CustomerStore.sortKey', context: context);

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

  late final _$sortAscAtom =
      Atom(name: '_CustomerStore.sortAsc', context: context);

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

  late final _$fetchCustomersAsyncAction =
      AsyncAction('_CustomerStore.fetchCustomers', context: context);

  @override
  Future<void> fetchCustomers() {
    return _$fetchCustomersAsyncAction.run(() => super.fetchCustomers());
  }

  late final _$addCustomerAsyncAction =
      AsyncAction('_CustomerStore.addCustomer', context: context);

  @override
  Future<void> addCustomer(CustomerModel customer) {
    return _$addCustomerAsyncAction.run(() => super.addCustomer(customer));
  }

  late final _$updateCustomerAsyncAction =
      AsyncAction('_CustomerStore.updateCustomer', context: context);

  @override
  Future<void> updateCustomer(String id, CustomerModel customer) {
    return _$updateCustomerAsyncAction
        .run(() => super.updateCustomer(id, customer));
  }

  late final _$deleteCustomerAsyncAction =
      AsyncAction('_CustomerStore.deleteCustomer', context: context);

  @override
  Future<void> deleteCustomer(String id) {
    return _$deleteCustomerAsyncAction.run(() => super.deleteCustomer(id));
  }

  late final _$_CustomerStoreActionController =
      ActionController(name: '_CustomerStore', context: context);

  @override
  void setCustomers(List<CustomerModel> newCustomers) {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.setCustomers');
    try {
      return super.setCustomers(newCustomers);
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCustomer(CustomerModel? customer) {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.setSelectedCustomer');
    try {
      return super.setSelectedCustomer(customer);
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFilter() {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.toggleFilter');
    try {
      return super.toggleFilter();
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedUserType(String text) {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.setSelectedUserType');
    try {
      return super.setSelectedUserType(text);
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllFilters() {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.clearAllFilters');
    try {
      return super.clearAllFilters();
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsFilterApplied(bool value) {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.setIsFilterApplied');
    try {
      return super.setIsFilterApplied(value);
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeSearchController() {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.initializeSearchController');
    try {
      return super.initializeSearchController();
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_CustomerStoreActionController.startAction(
        name: '_CustomerStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_CustomerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customers: ${customers},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
searchedText: ${searchedText},
selectedUserType: ${selectedUserType},
isFilterApplied: ${isFilterApplied},
currentTablePage: ${currentTablePage},
totalPages: ${totalPages},
isToggle: ${isToggle},
selectedCustomer: ${selectedCustomer},
sortKey: ${sortKey},
sortAsc: ${sortAsc},
filteredData: ${filteredData},
sortedData: ${sortedData},
paginatedData: ${paginatedData}
    ''';
  }
}
