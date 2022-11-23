import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/widgets.dart';

class ListSpents extends StatelessWidget {
  const ListSpents({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SpentListProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Config.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'new_spent');
        },
      ),
      appBar: AppBar(
        title: Text('Listado de gastos'),
        backgroundColor: Config.blue,
      ),
      body: MediaQuery.removePadding(
        context: context,
        child: ListView.builder(
          itemCount: list.spents.length,
          itemBuilder: (BuildContext context, int index) {
            Spent spend = list.spents[index];
            return card(
              spend!.name,
              spend!.category,
              "${spend.value}",
              spend.date,
            );
          },
        ),
      ),
    );
  }
}
