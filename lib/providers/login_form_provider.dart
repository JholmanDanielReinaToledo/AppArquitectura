import 'package:flutter/cupertino.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool _estaCargando = false;

  bool get estaCargando => _estaCargando;

  set estaCargando(bool value) {
    _estaCargando = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
