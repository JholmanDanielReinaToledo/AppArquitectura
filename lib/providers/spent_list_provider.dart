import 'package:flutter/cupertino.dart';

class SpentListProvider extends ChangeNotifier {
  List<Spent> spents = [];
  int total = 0;

  set updateSpend(Spent spent) {
    Spent index = spents.firstWhere((element) => element.uid == spent.uid);
    spents.remove(index);
    spents.add(spent);
    total = 0;
    for (var element in spents) {
      total = total + element.value;
    }
    notifyListeners();
  }

  set deleteSpend(Spent spent) {
    Spent index = spents.firstWhere((element) => element.uid == spent.uid);
    spents.remove(index);
    total = 0;
    for (var element in spents) {
      total = total + element.value;
    }
    notifyListeners();
  }

  get getSpend => spents;

  void insertSpend(Spent newPennd) {
    spents.add(newPennd);
    total = total + newPennd.value;
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
