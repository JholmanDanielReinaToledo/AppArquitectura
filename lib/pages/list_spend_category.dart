import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';

class ListSpendCategories extends StatelessWidget {
  const ListSpendCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SpendCategoriesListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Config.blue,
        title: Text('Categorias de los gastos'),
      ),
      body: ListView.builder(
        itemCount: list.categories.length,
        itemBuilder: (BuildContext context, int index) {
          SpendCategory spend = list.categories[index];
          return ListTile(
            title: Text(spend!.name),
          );
        },
      ),
    );
  }
}
