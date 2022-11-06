import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerPropio extends StatelessWidget {
  const DrawerPropio({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text('Ver gastos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_spents');
            },
          ),
          ListTile(
            title: const Text('Ver ingresos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_entries');
            },
          ),
          ListTile(
            title: const Text('Nuevo gasto'),
            onTap: () {
              Navigator.pushNamed(context, 'new_spent');
            },
          ),
          ListTile(
            title: const Text('Nuevo categoria de gasto'),
            onTap: () {
              Navigator.pushNamed(context, 'new_spend_category');
            },
          ),
          ListTile(
            title: const Text('Lista de categorias de los gastos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_spend_categories');
            },
          ),
          ListTile(
            title: const Text('Nuevo ingreso'),
            onTap: () {
              Navigator.pushNamed(context, 'new_entry');
            },
          ),
          ListTile(
            title: const Text('Lista de categorias de los ingresos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_spend_categories');
            },
          ),
          ListTile(
            title: const Text('Nuevo categoria de ingreso'),
            onTap: () {
              Navigator.pushNamed(context, 'new_entry');
            },
          ),
        ],
      ),
    );
  }
}
