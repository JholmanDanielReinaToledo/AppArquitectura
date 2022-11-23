import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_prquitectura/providers/entries_categories_list.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';

class DB {
  late FirebaseFirestore db;
  static String spendCollectionName = 'spents';
  static String entryCollectionName = 'entries';
  static String spendCategoryCollectionName = 'spentsCategory';
  static String entryCategoryCollectionName = 'entriesCategory';

  DB() {
    db = FirebaseFirestore.instance;
  }

  Future<List<Spent>> getSpents() async {
    List<Spent> list = [];

    final model = (db
        .collection(spendCollectionName)
        .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter<Spent>(
            fromFirestore: (snapshot, _) => Spent.fromJson(snapshot.data()!),
            toFirestore: (spent, _) => spent.toJson()));

    final fet = (await model.get());

    print(fet.docs.map((e) => list.add(e.data())));

    return list;
  }

  Future<List<Entry>> getEntries() async {
    List<Entry> list = [];

    final model = (db
        .collection(entryCollectionName)
        .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter<Entry>(
            fromFirestore: (snapshot, _) => Entry.fromJson(snapshot.data()!),
            toFirestore: (entry, _) => entry.toJson()));

    final fet = (await model.get());

    print(fet.docs.map((e) => list.add(e.data())));

    return list;
  }

  Future<List<EntryCategory>> getEntryCategory() async {
    List<EntryCategory> list = [];

    final model = (db
        .collection(entryCategoryCollectionName)
        .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter<EntryCategory>(
            fromFirestore: (snapshot, _) =>
                EntryCategory.fromJson(snapshot.data()!),
            toFirestore: (entry, _) => entry.toJson()));

    final fet = (await model.get());

    print(fet.docs.map((e) => list.add(e.data())));

    return list;
  }

  Future<List<SpendCategory>> getSpendCategory() async {
    List<SpendCategory> list = [];

    final model = (db
        .collection(spendCategoryCollectionName)
        .where('uidUser', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter<SpendCategory>(
            fromFirestore: (snapshot, _) =>
                SpendCategory.fromJson(snapshot.data()!),
            toFirestore: (entry, _) => entry.toJson()));

    final fet = (await model.get());

    print(fet.docs.map((e) => list.add(e.data())));

    return list;
  }

  addSpent(Spent spent) {
    db
        .collection(spendCollectionName)
        .add(spent.toJson())
        .then((value) => print(value))
        .catchError((onError) => print(onError));
  }

  addEntry(Entry entry) {
    db
        .collection(entryCollectionName)
        .add(entry.toJson())
        .then((value) => print(value))
        .catchError((onError) => print(onError));
  }

  addCategorySpent(SpendCategory spendCategory) {
    db
        .collection(spendCategoryCollectionName)
        .add(spendCategory.toJson())
        .then((value) => print(value))
        .catchError((onError) => print(onError));
  }

  addCategoryEntry(EntryCategory entryCategory) {
    db
        .collection(entryCategoryCollectionName)
        .add(entryCategory.toJson())
        .then((value) => print(value))
        .catchError((onError) => print(onError));
  }
}
