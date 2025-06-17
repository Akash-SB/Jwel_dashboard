// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserDataStore on _UserDataStore, Store {
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
  String toString() {
    return '''
tabIndex: ${tabIndex}
    ''';
  }
}
