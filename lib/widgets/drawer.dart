import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/services/auth_service.dart';

class DrawerPropio extends StatelessWidget {
  const DrawerPropio({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Config.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'FinTech',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          FirebaseAuth.instance.currentUser!.photoURL ?? ''),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email ?? '',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? '',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Gastos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_spents');
            },
          ),
          ListTile(
            title: const Text('Ingresos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_entries');
            },
          ),
          ListTile(
            title: const Text('Categorias de los gastos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_spend_categories');
            },
          ),
          ListTile(
            title: const Text('Categorias de los ingresos'),
            onTap: () {
              Navigator.pushNamed(context, 'list_entry_categories');
            },
          ),
          ListTile(
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              AuthService().signOut();
            },
          ),
        ],
      ),
    );
  }
}
