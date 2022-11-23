import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nuevo categoria de gasto'),
        backgroundColor: Config.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: keyForm,
          child: formUI(list),
        ),
      ),
    );
  }

  Widget formUI(SpendCategoriesListProvider list) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            validator: validateName,
            controller: nameCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre',
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('Guardar'),
          onPressed: () {
            SpendCategory newPennd = save();
            print(newPennd.name);
            if (newPennd != null) {
              list.insertCategory(newPennd);
              Navigator.pushReplacementNamed(context, 'list_spend_categories');
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
        ),
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
