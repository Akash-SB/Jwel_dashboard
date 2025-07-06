// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InvoiceStore on _InvoiceStore, Store {
  Computed<List<InvoiceModel>>? _$filteredDataComputed;

  @override
  List<InvoiceModel> get filteredData => (_$filteredDataComputed ??=
          Computed<List<InvoiceModel>>(() => super.filteredData,
              name: '_InvoiceStore.filteredData'))
      .value;
  Computed<List<InvoiceModel>>? _$sortedDataComputed;

  @override
  List<InvoiceModel> get sortedData => (_$sortedDataComputed ??=
          Computed<List<InvoiceModel>>(() => super.sortedData,
              name: '_InvoiceStore.sortedData'))
      .value;
  Computed<List<InvoiceModel>>? _$paginatedDataComputed;

  @override
  List<InvoiceModel> get paginatedData => (_$paginatedDataComputed ??=
          Computed<List<InvoiceModel>>(() => super.paginatedData,
              name: '_InvoiceStore.paginatedData'))
      .value;

  late final _$invoicesAtom =
      Atom(name: '_InvoiceStore.invoices', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_InvoiceStore.isLoading', context: context);

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
      Atom(name: '_InvoiceStore.errorMessage', context: context);

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

  late final _$selectedPaymentStatusAtom =
      Atom(name: '_InvoiceStore.selectedPaymentStatus', context: context);

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

  late final _$searchQueryAtom =
      Atom(name: '_InvoiceStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$ledgerControllerAtom =
      Atom(name: '_InvoiceStore.ledgerController', context: context);

  @override
  TextEditingController get ledgerController {
    _$ledgerControllerAtom.reportRead();
    return super.ledgerController;
  }

  bool _ledgerControllerIsInitialized = false;

  @override
  set ledgerController(TextEditingController value) {
    _$ledgerControllerAtom.reportWrite(
        value, _ledgerControllerIsInitialized ? super.ledgerController : null,
        () {
      super.ledgerController = value;
      _ledgerControllerIsInitialized = true;
    });
  }

  late final _$currentTablePageAtom =
      Atom(name: '_InvoiceStore.currentTablePage', context: context);

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
      Atom(name: '_InvoiceStore.totalPages', context: context);

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

  late final _$sortKeyAtom =
      Atom(name: '_InvoiceStore.sortKey', context: context);

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
      Atom(name: '_InvoiceStore.sortAsc', context: context);

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

  late final _$fetchInvoicesAsyncAction =
      AsyncAction('_InvoiceStore.fetchInvoices', context: context);

  @override
  Future<void> fetchInvoices() {
    return _$fetchInvoicesAsyncAction.run(() => super.fetchInvoices());
  }

  late final _$addInvoiceAsyncAction =
      AsyncAction('_InvoiceStore.addInvoice', context: context);

  @override
  Future<void> addInvoice(InvoiceModel invoice) {
    return _$addInvoiceAsyncAction.run(() => super.addInvoice(invoice));
  }

  late final _$updateInvoiceAsyncAction =
      AsyncAction('_InvoiceStore.updateInvoice', context: context);

  @override
  Future<void> updateInvoice(String id, InvoiceModel invoice) {
    return _$updateInvoiceAsyncAction
        .run(() => super.updateInvoice(id, invoice));
  }

  late final _$deleteInvoiceAsyncAction =
      AsyncAction('_InvoiceStore.deleteInvoice', context: context);

  @override
  Future<void> deleteInvoice(String id) {
    return _$deleteInvoiceAsyncAction.run(() => super.deleteInvoice(id));
  }

  late final _$_InvoiceStoreActionController =
      ActionController(name: '_InvoiceStore', context: context);

  @override
  void setCurrentPageIndex(int index) {
    final _$actionInfo = _$_InvoiceStoreActionController.startAction(
        name: '_InvoiceStore.setCurrentPageIndex');
    try {
      return super.setCurrentPageIndex(index);
    } finally {
      _$_InvoiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_InvoiceStoreActionController.startAction(
        name: '_InvoiceStore.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_InvoiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedPaymentStatus(String status) {
    final _$actionInfo = _$_InvoiceStoreActionController.startAction(
        name: '_InvoiceStore.setSelectedPaymentStatus');
    try {
      return super.setSelectedPaymentStatus(status);
    } finally {
      _$_InvoiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initSearchController() {
    final _$actionInfo = _$_InvoiceStoreActionController.startAction(
        name: '_InvoiceStore.initSearchController');
    try {
      return super.initSearchController();
    } finally {
      _$_InvoiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortKey(String? key) {
    final _$actionInfo = _$_InvoiceStoreActionController.startAction(
        name: '_InvoiceStore.setSortKey');
    try {
      return super.setSortKey(key);
    } finally {
      _$_InvoiceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
invoices: ${invoices},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
selectedPaymentStatus: ${selectedPaymentStatus},
searchQuery: ${searchQuery},
ledgerController: ${ledgerController},
currentTablePage: ${currentTablePage},
totalPages: ${totalPages},
sortKey: ${sortKey},
sortAsc: ${sortAsc},
filteredData: ${filteredData},
sortedData: ${sortedData},
paginatedData: ${paginatedData}
    ''';
  }
}
