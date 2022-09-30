import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FinTech'),
      ),
      body: FooterView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Center(
              child: Text('Home Page'),
            ),
          )
        ],
        footer: Footer(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.all(5),
          child: Text('Este es un pie de apgina personalizado!!'),
        ),
      ),
    );
  }
}
