// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginScreenStore on _LoginScreenStore, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_LoginScreenStore.isValid'))
      .value;

  late final _$emailAtom =
      Atom(name: '_LoginScreenStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginScreenStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginScreenStore.login', context: context);

  @override
  Future<bool> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$_LoginScreenStoreActionController =
      ActionController(name: '_LoginScreenStore', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_LoginScreenStoreActionController.startAction(
        name: '_LoginScreenStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginScreenStoreActionController.startAction(
        name: '_LoginScreenStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFields() {
    final _$actionInfo = _$_LoginScreenStoreActionController.startAction(
        name: '_LoginScreenStore.resetFields');
    try {
      return super.resetFields();
    } finally {
      _$_LoginScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
isValid: ${isValid}
    ''';
  }
}
