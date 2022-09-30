import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/login_form_provider.dart';
import 'package:proyecto_prquitectura/providers/spend_form_provider.dart';
import 'package:proyecto_prquitectura/widgets/spend_form.dart';

class NewSpentPage extends StatelessWidget {
  const NewSpentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ChangeNotifierProvider(
            create: (_) => SpendFormProvider(),
            child: SpendForm(),
          ),
        ],
      ),
    );
  }
}
