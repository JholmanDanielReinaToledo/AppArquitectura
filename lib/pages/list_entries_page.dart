import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/widgets.dart';

class ListEntries extends StatelessWidget {
  const ListEntries({super.key});

  @override
  Widget build(BuildContext context) {
    
    final list = Provider.of<EntryListProvider>(context);
    print(list.entries);
    return Scaffold(
      appBar: AppBar(
          title: Text('Ingresos'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
              icon: Icon(Icons.arrow_back_outlined),
            ),
          ],
        ),
      body: MediaQuery.removePadding(
        context: context,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return card(
              (index + 1).toString(),
              ("Sub ${index + 1}"),
              () => print(index),
            );
          },
        ),
      ),
    );
  }
}
