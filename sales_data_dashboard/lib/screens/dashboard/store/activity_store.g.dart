// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ActivityStore on _ActivityStore, Store {
  late final _$invoicesAtom =
      Atom(name: '_ActivityStore.invoices', context: context);

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

  late final _$activitiesAtom =
      Atom(name: '_ActivityStore.activities', context: context);

  @override
  ObservableList<Activity> get activities {
    _$activitiesAtom.reportRead();
    return super.activities;
  }

  @override
  set activities(ObservableList<Activity> value) {
    _$activitiesAtom.reportWrite(value, super.activities, () {
      super.activities = value;
    });
  }

  late final _$notificationsAtom =
      Atom(name: '_ActivityStore.notifications', context: context);

  @override
  ObservableList<InvoiceNotificationModel> get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(ObservableList<InvoiceNotificationModel> value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ActivityStore.isLoading', context: context);

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
      Atom(name: '_ActivityStore.errorMessage', context: context);

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
      AsyncAction('_ActivityStore.fetchInvoices', context: context);

  @override
  Future<void> fetchInvoices() {
    return _$fetchInvoicesAsyncAction.run(() => super.fetchInvoices());
  }

  late final _$_ActivityStoreActionController =
      ActionController(name: '_ActivityStore', context: context);

  @override
  void setnotificationList(List<InvoiceNotificationModel> list) {
    final _$actionInfo = _$_ActivityStoreActionController.startAction(
        name: '_ActivityStore.setnotificationList');
    try {
      return super.setnotificationList(list);
    } finally {
      _$_ActivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInvoices(List<InvoiceModel> invoices) {
    final _$actionInfo = _$_ActivityStoreActionController.startAction(
        name: '_ActivityStore.setInvoices');
    try {
      return super.setInvoices(invoices);
    } finally {
      _$_ActivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
invoices: ${invoices},
activities: ${activities},
notifications: ${notifications},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
