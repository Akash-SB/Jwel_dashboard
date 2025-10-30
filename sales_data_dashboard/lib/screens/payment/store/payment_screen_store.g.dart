// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaymentScreenStore on _PaymentScreenStore, Store {
  Computed<List<PaymentModel>>? _$paginatedDataComputed;

  @override
  List<PaymentModel> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<PaymentModel>>(() => super.paginatedData,
              name: '_PaymentScreenStore.paginatedData'))
      .value;
  Computed<List<PaymentModel>>? _$sortedDataComputed;

  @override
  List<PaymentModel> get sortedData => (_$sortedDataComputed ??=
          Computed<List<PaymentModel>>(() => super.sortedData,
              name: '_PaymentScreenStore.sortedData'))
      .value;
  Computed<List<PaymentModel>>? _$filteredDataComputed;

  @override
  List<PaymentModel> get filteredData => (_$filteredDataComputed ??=
          Computed<List<PaymentModel>>(() => super.filteredData,
              name: '_PaymentScreenStore.filteredData'))
      .value;

  late final _$paymentListAtom =
      Atom(name: '_PaymentScreenStore.paymentList', context: context);

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

  late final _$partiesListAtom =
      Atom(name: '_PaymentScreenStore.partiesList', context: context);

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

  late final _$selectedItemAtom =
      Atom(name: '_PaymentScreenStore.selectedItem', context: context);

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

  late final _$selectedPartyAtom =
      Atom(name: '_PaymentScreenStore.selectedParty', context: context);

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

  late final _$selectedStatusAtom =
      Atom(name: '_PaymentScreenStore.selectedStatus', context: context);

  @override
  String get selectedStatus {
    _$selectedStatusAtom.reportRead();
    return super.selectedStatus;
  }

  @override
  set selectedStatus(String value) {
    _$selectedStatusAtom.reportWrite(value, super.selectedStatus, () {
      super.selectedStatus = value;
    });
  }

  late final _$sortKeyAtom =
      Atom(name: '_PaymentScreenStore.sortKey', context: context);

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
      Atom(name: '_PaymentScreenStore.totalPages', context: context);

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
      Atom(name: '_PaymentScreenStore.sortAsc', context: context);

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
      Atom(name: '_PaymentScreenStore.customerType', context: context);

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
      Atom(name: '_PaymentScreenStore.isFilterApplied', context: context);

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
      Atom(name: '_PaymentScreenStore.agentDetails', context: context);

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
      Atom(name: '_PaymentScreenStore.isAgentSelected', context: context);

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
      Atom(name: '_PaymentScreenStore.searchedText', context: context);

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
      Atom(name: '_PaymentScreenStore.selectedRowCount', context: context);

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
      Atom(name: '_PaymentScreenStore.currentTablePage', context: context);

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
      Atom(name: '_PaymentScreenStore.isLoading', context: context);

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
      Atom(name: '_PaymentScreenStore.errorMessage', context: context);

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

  late final _$fetchPaymentsAsyncAction =
      AsyncAction('_PaymentScreenStore.fetchPayments', context: context);

  @override
  Future<void> fetchPayments() {
    return _$fetchPaymentsAsyncAction.run(() => super.fetchPayments());
  }

  late final _$addPaymentAsyncAction =
      AsyncAction('_PaymentScreenStore.addPayment', context: context);

  @override
  Future<void> addPayment(PaymentModel payment) {
    return _$addPaymentAsyncAction.run(() => super.addPayment(payment));
  }

  late final _$updatePaymentAsyncAction =
      AsyncAction('_PaymentScreenStore.updatePayment', context: context);

  @override
  Future<void> updatePayment(PaymentModel payment) {
    return _$updatePaymentAsyncAction.run(() => super.updatePayment(payment));
  }

  late final _$deletePaymentAsyncAction =
      AsyncAction('_PaymentScreenStore.deletePayment', context: context);

  @override
  Future<void> deletePayment(String id) {
    return _$deletePaymentAsyncAction.run(() => super.deletePayment(id));
  }

  late final _$_PaymentScreenStoreActionController =
      ActionController(name: '_PaymentScreenStore', context: context);

  @override
  void setIsAgentSelected(bool value) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setIsAgentSelected');
    try {
      return super.setIsAgentSelected(value);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedStatus(String value) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setSelectedStatus');
    try {
      return super.setSelectedStatus(value);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isFiltersApplied() {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.isFiltersApplied');
    try {
      return super.isFiltersApplied();
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCustomerType(String type) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setCustomerType');
    try {
      return super.setCustomerType(type);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgentDetails(Party agent) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setAgentDetails');
    try {
      return super.setAgentDetails(agent);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedParty(Party party) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setSelectedParty');
    try {
      return super.setSelectedParty(party);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String text) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setSearchText');
    try {
      return super.setSearchText(text);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllFilters() {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.clearAllFilters');
    try {
      return super.clearAllFilters();
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calculateTotalPages() {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.calculateTotalPages');
    try {
      return super.calculateTotalPages();
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorMessage(String? message) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setErrorMessage');
    try {
      return super.setErrorMessage(message);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentList(List<PaymentModel> payments) {
    final _$actionInfo = _$_PaymentScreenStoreActionController.startAction(
        name: '_PaymentScreenStore.setPaymentList');
    try {
      return super.setPaymentList(payments);
    } finally {
      _$_PaymentScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
paymentList: ${paymentList},
partiesList: ${partiesList},
selectedItem: ${selectedItem},
selectedParty: ${selectedParty},
selectedStatus: ${selectedStatus},
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
