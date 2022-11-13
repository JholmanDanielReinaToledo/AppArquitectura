import 'package:flutter/cupertino.dart';

class EntryCategoriesListProvider extends ChangeNotifier {
  List<EntryCategory> categories = [
    EntryCategory(uid: "1", name: "Salario"),
    EntryCategory(uid: "2", name: "Prestamo"),
  ];

  get getCategories => categories;

  void insertCategory(EntryCategory newCategory) {
    categories.add(newCategory);
    notifyListeners();
  }
}

class EntryCategory {
  String uid = "";
  String name = "";
  EntryCategory({uid, required this.name});
}
