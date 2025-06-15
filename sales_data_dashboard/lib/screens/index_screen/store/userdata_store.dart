import 'package:mobx/mobx.dart';

part 'userdata_store.g.dart';

class UserDataStore = _UserDataStore with _$UserDataStore;

abstract class _UserDataStore with Store {
  @observable
  int tabIndex = 0;

  @action
  void setTab(int index) {
    tabIndex = index;
  }
}
