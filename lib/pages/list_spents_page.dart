import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/widgets.dart';

class ListSpents extends StatelessWidget {
  const ListSpents({super.key});

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SpentListProvider>(context);
    print(list.spents);
    return Scaffold(
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
