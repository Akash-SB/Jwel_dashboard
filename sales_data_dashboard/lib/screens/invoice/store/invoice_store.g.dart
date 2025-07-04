// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InvoiceStore on _InvoiceStore, Store {
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

  @override
  String toString() {
    return '''
invoices: ${invoices},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
