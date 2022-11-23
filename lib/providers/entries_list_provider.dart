import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_prquitectura/db/index.dart';

class EntryListProvider extends ChangeNotifier {
  List<Entry> entries = [];
  int total = 0;

  EntryListProvider() {
    cargarLista();
  }

  cargarLista() async {
    entries = await DB().getEntries();
    for (Entry item in entries) {
      total = total + item.value;
    }
    notifyListeners();
  }

  set updateEntries(Entry entry) {
    Entry index = entries.firstWhere((element) => element.uid == entry.uid);
    entries.remove(index);
    entries.add(entry);
    total = 0;
    for (var element in entries) {
      total = total + element.value;
    }
    notifyListeners();
  }

  set deleteEntry(Entry entry) {
    Entry index = entries.firstWhere((element) => element.uid == entry.uid);
    entries.remove(index);
    total = 0;
    for (var element in entries) {
      total = total + element.value;
    }
    notifyListeners();
  }

  /* set insertEntry(Entry entry) {
    entries.add(entry);
    notifyListeners();
  } */

  get getEntry => entries;

  void insertEntry(Entry entry) {
    DB().addEntry(entry);
    entries.add(entry);
    total = total + entry.value;
    notifyListeners();
  }
}

class Entry {
  String uid = "";
  int value = 0;
  String category = "";
  DateTime date = DateTime.now();
  String name = "";
  late String uidUser;

  Entry() {
    uidUser = FirebaseAuth.instance.currentUser!.uid;
  }

  Entry.fromJson(Map<String, dynamic> json) {
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
