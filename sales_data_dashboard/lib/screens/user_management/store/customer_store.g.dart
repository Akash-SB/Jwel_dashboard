// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerStore on _CustomerStore, Store {
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

  @override
  String toString() {
    return '''
customers: ${customers},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
