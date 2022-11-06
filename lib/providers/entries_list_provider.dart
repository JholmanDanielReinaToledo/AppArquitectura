import 'package:flutter/cupertino.dart';

class EntryListProvider extends ChangeNotifier {
  List<Entry> entries = [];
  int total = 0;

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

  void insertEntry(Entry newPennd) {
    entries.add(newPennd);
    total = total + newPennd.value;
    notifyListeners();
  }
}

class Entry {
  String uid = "";
  int value = 0;
  String category = "";
  DateTime date = DateTime.now();
  String name = "";
}
