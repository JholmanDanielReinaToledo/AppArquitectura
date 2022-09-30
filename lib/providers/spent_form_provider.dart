import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class SpentFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    return formKey.currentState?.validate() ?? false;
  }
}
