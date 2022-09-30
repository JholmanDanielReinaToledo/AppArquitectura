import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/spend_form_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/ui/input_decorations.dart';

class SpendForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<SpendFormProvider>(context);
    // final listSpend = Provider.of<SpentListProvider>(context);

    // Initial Selected Value
    String dropdownvalue = 'Comida';

    // List of items in our dropdown menu
    var items = [
      'Transporte',
      'Educación',
      'Otros',
      'Comida',
    ];

    return Container(
      key: loginForm.formkey,
      child: Form(
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
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                print(newValue);
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginForm.estaCargando ? 'Espere' : 'Ingresar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: loginForm.estaCargando
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;
                        loginForm.estaCargando = true;
                        await Future.delayed(Duration(seconds: 2));

                        loginForm.estaCargando = false;
                        // Spent newSpent = new Spent();
                        // newSpent.category = loginForm.category;
                        // listSpend.insertSpend(newSpent);
                        Navigator.pushReplacementNamed(context, 'home');
                      })
          ],
        ),
      ),
    );
  }
}
