import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_prquitectura/db/index.dart';

class SpendCategoriesListProvider extends ChangeNotifier {
  SpendCategoriesListProvider() {
    cargarLista();
  }

  List<SpendCategory> categories = [
    SpendCategory(uid: "1", name: "Transporte"),
    SpendCategory(uid: "2", name: "Comida"),
    SpendCategory(uid: "3", name: "Vivienda"),
  ];

  cargarLista() async {
    List<SpendCategory> result = await DB().getSpendCategory();
    for (SpendCategory item in result) {
      categories.add(item);
    }
    notifyListeners();
  }

  get getCategories => categories;

  void insertCategory(SpendCategory newCategory) {
    DB().addCategorySpent(newCategory);
    categories.add(newCategory);
    notifyListeners();
  }
}

class SpendCategory {
  String uid = "";
  String name = "";
  SpendCategory({uid, required this.name}) {
    uidUser = FirebaseAuth.instance.currentUser!.uid;
  }
  late String uidUser;

  SpendCategory.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['uidUser'] = uidUser;
    return _data;
  }
}
