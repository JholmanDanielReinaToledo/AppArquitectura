import 'package:flutter/cupertino.dart';

class SpendCategoriesListProvider extends ChangeNotifier {
  List<SpendCategory> categories = [];

  get getCategories => categories;

  void insertCategory(SpendCategory newCategory) {
    categories.add(newCategory);
    notifyListeners();
  }
}

class SpendCategory {
  String uid = "";
  String name = "";
}
