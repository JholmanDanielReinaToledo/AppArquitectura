import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';
import 'package:proyecto_prquitectura/widgets/card.dart';

class ListSpendCategories extends StatelessWidget {
  const ListSpendCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SpendCategoriesListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de categorias de los gastos'),
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
            SpendCategory spend = list.categories[index];
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
