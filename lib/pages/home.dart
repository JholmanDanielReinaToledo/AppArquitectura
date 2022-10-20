import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('FinTech'),
      ),
      body: FooterView(
        footer: Footer(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.all(5),
          child: Text(''),
        ),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Ver gastos'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'list_spents');
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Ver ingresos'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'list_entries');
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Nuevo gasto'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'new_spent');
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Nuevo categoria de gasto'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'new_spend_category');
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Lista de categorias de los gastos'),
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, 'list_spend_categories');
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Nuevo ingreso'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'new_entry');
              },
            ),
          ),
        ],
      ),
    );
  }
}
