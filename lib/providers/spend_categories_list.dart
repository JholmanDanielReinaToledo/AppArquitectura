import 'package:flutter/cupertino.dart';

class SpendCategoriesListProvider extends ChangeNotifier {
  List<SpendCategory> categories = [
    SpendCategory(uid: "1", name: "Transporte"),
    SpendCategory(uid: "2", name: "Comida"),
    SpendCategory(uid: "3", name: "Vivienda"),
  ];

  get getCategories => categories;

  void insertCategory(SpendCategory newCategory) {
    categories.add(newCategory);
    notifyListeners();
  }
}

class SpendCategory {
  String uid = "";
  String name = "";
  SpendCategory({uid, required this.name}) {}
}
