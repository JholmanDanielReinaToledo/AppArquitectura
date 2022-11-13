import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/entries_categories_list.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';

class EntryCategoryForm extends StatefulWidget {
  const EntryCategoryForm({super.key});

  @override
  State<EntryCategoryForm> createState() => EntryCategoryFormState();
}

class EntryCategoryFormState extends State<EntryCategoryForm> {
  GlobalKey<FormState> keyForm = GlobalKey();

  TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<EntryCategoriesListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Nuevo categoria de ingreso'),
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

  Widget formUI(EntryCategoriesListProvider list) {
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
            EntryCategory newPennd = save();
            // ignore: unnecessary_null_comparison
            if (newPennd != null) {
              list.insertCategory(newPennd);
              Navigator.pushReplacementNamed(context, 'list_entry_categories');
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
      EntryCategory newSpendCategory = EntryCategory(name: nameCtrl.text);
      keyForm.currentState!.reset();

      return newSpendCategory;
    }
    return null;
  }
}
