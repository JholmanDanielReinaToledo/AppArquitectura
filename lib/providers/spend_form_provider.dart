import 'package:flutter/cupertino.dart';

class SpendFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String uid = "";
  int value = 0;
  String category = "";
  DateTime date = DateTime.now();
  String name = "";
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
