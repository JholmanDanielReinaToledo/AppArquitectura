import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class SpentListProvider extends ChangeNotifier {
  List<Spent> spents = [];

  set updateSpend(Spent spent) {
    Spent index = spents.firstWhere((element) => element.uid == spent.uid);
    spents.remove(index);
    spents.add(spent);
    notifyListeners();
  }

  set deleteSpend(Spent spent) {
    Spent index = spents.firstWhere((element) => element.uid == spent.uid);
    spents.remove(index);
    notifyListeners();
  }

  /* set insertSpend(Spent spent) {
    spents.add(spent);
    notifyListeners();
  } */

  get getSpend => spents;

  void insertSpend(Spent newPennd) {
    spents.add(newPennd);
    notifyListeners();
  }
}

class Spent {
  String uid = "";
  int value = 0;
  String category = "";
  DateTime date = DateTime.now();
  String name = "";
}
