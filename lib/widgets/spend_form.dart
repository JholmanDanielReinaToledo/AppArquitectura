import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/spend_form_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/ui/input_decorations.dart';

class SpendForm2 extends StatefulWidget {
  const SpendForm2({Key? key}) : super(key: key);

  @override
  State<SpendForm2> createState() => _SpendForm2State();
}

class _SpendForm2State extends State<SpendForm2> {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<SpendFormProvider>(context);

    final items = [
      'Transporte',
      'Educación',
      'Otros',
      'Comida',
    ];

    return Scaffold(
      key: loginForm.formkey,
      body: Form(
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                labelText: 'Valor',
                prefix: Icons.money,
                hintText: '0',
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                } else {
                  return 'Debe ser mayor a 0';
                }
              },
            ),
            SizedBox(
              height: 50,
            ),
            DropdownButtonFormField<String>(
              items: items.map(buildMenuItem).toList(),
              onChanged: (String? newValue) => {
                print(newValue) // value = newValue,
              },
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.estaCargando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!loginForm.isValidForm()) return;
                      loginForm.estaCargando = true;
                      await Future.delayed(Duration(seconds: 2));

                      loginForm.estaCargando = false;
                      Spent newSpent = Spent();
                      newSpent.category = loginForm.category;
                      // listSpend.insertSpend(newSpent);
                      Navigator.pushReplacementNamed(context, 'home');
                    },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Ingresar', // loginForm.estaCargando ? 'Espere' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
