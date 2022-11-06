import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/widgets/drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final entriesProvider = Provider.of<EntryListProvider>(context);
    final spendsProvider = Provider.of<SpentListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: DrawerPropio(),
      appBar: AppBar(
        title: Text('FinTech'),
      ),
      body: FooterView(
        footer: Footer(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.all(5),
          child: Text('Total ingresos ${entriesProvider.total.toString()}'),
        ),
        children: <Widget>[
          Text('Total ingresos ${entriesProvider.total.toString()}'),
          Text('Total gastos ${spendsProvider.total.toString()}'),
        ],
      ),
    );
  }
}
