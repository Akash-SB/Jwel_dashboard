import 'package:mobx/mobx.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStore with _$LoginScreenStore;

abstract class _LoginScreenStore with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @computed
  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void resetFields() {
    email = '';
    password = '';
  }

  @action
  Future<bool> login() async {
    if (!isValid) return false;
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
