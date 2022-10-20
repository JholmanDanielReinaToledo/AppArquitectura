import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class EntryListProvider extends ChangeNotifier {
  List<Entry> entries = [];

  set updateEntries(Entry entry) {
    Entry index = entries.firstWhere((element) => element.uid == entry.uid);
    entries.remove(index);
    entries.add(entry);
    notifyListeners();
  }

  set deleteEntry(Entry entry) {
    Entry index = entries.firstWhere((element) => element.uid == entry.uid);
    entries.remove(index);
    notifyListeners();
  }

  /* set insertEntry(Entry entry) {
    entries.add(entry);
    notifyListeners();
  } */

  get getEntry => entries;

  void insertEntry(Entry newPennd) {
    entries.add(newPennd);
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