// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdata_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

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
