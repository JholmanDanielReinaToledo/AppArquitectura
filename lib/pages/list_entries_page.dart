import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/widgets.dart';

class ListEntries extends StatelessWidget {
  const ListEntries({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<EntryListProvider>(context);
    print(list.entries);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Config.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'new_entry');
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Ingresos'),
        backgroundColor: Config.blue,
      ),
      body: MediaQuery.removePadding(
        context: context,
        child: ListView.builder(
          itemCount: list.entries.length,
          itemBuilder: (BuildContext context, int index) {
            Entry spend = list.entries[index];
            return card(
              spend.name,
              spend.category,
              "${spend.value}",
              spend.date,
            );
          },
        ),
      ),
    );
  }
}
