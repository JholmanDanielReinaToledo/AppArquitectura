import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_prquitectura/db/index.dart';

class EntryCategoriesListProvider extends ChangeNotifier {
  List<EntryCategory> categories = [
    EntryCategory(uid: "1", name: "Salario"),
    EntryCategory(uid: "2", name: "Prestamo"),
  ];

  EntryCategoriesListProvider() {
    cargarLista();
  }

  cargarLista() async {
    List<EntryCategory> result = await DB().getEntryCategory();
    for (EntryCategory item in result) {
      categories.add(item);
    }
    notifyListeners();
  }

  get getCategories => categories;

  void insertCategory(EntryCategory newCategory) {
    DB().addCategoryEntry(newCategory);
    categories.add(newCategory);
    notifyListeners();
  }
}

class EntryCategory {
  String uid = "";
  String name = "";
  late String uidUser;

  EntryCategory({uid, required this.name}) {
    uidUser = FirebaseAuth.instance.currentUser!.uid;
  }

  EntryCategory.fromJson(Map<String, dynamic> json) {
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
