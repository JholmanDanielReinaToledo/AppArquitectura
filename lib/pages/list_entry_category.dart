import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/entries_categories_list.dart';
import 'package:proyecto_prquitectura/widgets/card.dart';

class ListEntryCategories extends StatelessWidget {
  const ListEntryCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<EntryCategoriesListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Listado de categorias de los ingresos'),
        leading: MaterialButton(
          child: Icon(Icons.arrow_left_rounded, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
        ),
      ),
      body: MediaQuery.removePadding(
        context: context,
        child: ListView.builder(
          itemCount: list.categories.length,
          itemBuilder: (BuildContext context, int index) {
            EntryCategory spend = list.categories[index];
            return card(
              spend!.name,
              "",
              "",
              () => print(index),
            );
          },
        ),
      ),
    );
  }
}
