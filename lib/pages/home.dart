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
          child: Text('Este es un pie de apgina personalizado!!'),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Center(
              child: Text('Home Page'),
            ),
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.blue,
            child: Text('Ver gastos'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'list_spents');
            },
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.blue,
            child: Text('Ver ingresos'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'list_entries');
            },
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.blue,
            child: Text('Nuevo gasto'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'new_spent');
            },
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            color: Colors.blue,
            child: Text('Nuevo categoria de gasto'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'new_spend_category');
            },
          ),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            child: Text('Lista de categorias de los gastos'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'list_spend_categories');
            },
          ),
          MaterialButton(
            color: Colors.lightGreen,
            child: Text('Nuevo ingreso'),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'new_entry');
            },
          ),
        ],
      ),
    );
  }
}
