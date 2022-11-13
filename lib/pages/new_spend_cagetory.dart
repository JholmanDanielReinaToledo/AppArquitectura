import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';

class SpendCategoryForm extends StatefulWidget {
  const SpendCategoryForm({super.key});

  @override
  State<SpendCategoryForm> createState() => _SpendCategoryFormState();
}

class _SpendCategoryFormState extends State<SpendCategoryForm> {
  GlobalKey<FormState> keyForm = GlobalKey();

  TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SpendCategoriesListProvider>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nuevo gasto'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(60.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: keyForm,
              child: formUI(list),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI(SpendCategoriesListProvider list) {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.assignment,
            TextFormField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
              validator: validateName,
            )),
        GestureDetector(
            onTap: () {
              SpendCategory newPennd = save();
              print(newPennd.name);
              if (newPennd != null) {
                list.insertCategory(newPennd);
                Navigator.pushReplacementNamed(
                    context, 'list_spend_categories');
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("Ha ocurrido un error"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFF0EDED2),
                  Color(0xFF03A0FE),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Text("Guardar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ))
      ],
    );
  }

  String? validateName(String? value) {
    if (value != null) {
      return null;
    }
    return "El nombre es necesario";
  }

  save() {
    if (keyForm.currentState!.validate()) {
      print("Nombre ${nameCtrl.text}");
      SpendCategory newSpendCategory = SpendCategory(name: nameCtrl.text!);
      keyForm.currentState!.reset();

      return newSpendCategory;
    }
  }
}
