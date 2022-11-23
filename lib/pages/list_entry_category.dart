import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/entries_categories_list.dart';

class ListEntryCategories extends StatelessWidget {
  const ListEntryCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<EntryCategoriesListProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Config.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'new_entry_category');
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Config.blue,
        title: Text('Categorias de los ingresos'),
      ),
      body: ListView.builder(
        itemCount: list.categories.length,
        itemBuilder: (BuildContext context, int index) {
          EntryCategory spend = list.categories[index];
          return ListTile(
            title: Text(spend!.name),
          );
        },
      ),
    );
  }
}
