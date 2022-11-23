import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_prquitectura/db/index.dart';

class SpentListProvider extends ChangeNotifier {
  List<Spent> spents = [];
  int total = 0;

  SpentListProvider() {
    cargarLista();
  }

  cargarLista() async {
    spents = await DB().getSpents();
    for (Spent item in spents) {
      total = total + item.value;
    }
    notifyListeners();
  }

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
    DB().addSpent(newPennd);
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
  late String uidUser;

  Spent() {
    uidUser = FirebaseAuth.instance.currentUser!.uid;
  }

  Spent.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    value = json["value"];
    category = json["category"];
    // date = json["date"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['category'] = category;
    _data['date'] = date;
    _data['name'] = name;
    _data['uidUser'] = uidUser;
    return _data;
  }
}
