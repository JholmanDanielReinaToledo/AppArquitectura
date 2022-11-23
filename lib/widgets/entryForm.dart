import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/entries_categories_list.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';

class EntryForm extends StatefulWidget {
  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController valorCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  late EntryCategoriesListProvider entryCatProvider;

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<EntryListProvider>(context);
    setState(() {
      entryCatProvider = Provider.of<EntryCategoriesListProvider>(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Ingreso'),
        backgroundColor: Config.blue,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: keyForm,
            child: formUI(list),
          ),
        ),
      ),
    );
  }

  EntryCategory? categoria;

  Widget formUI(EntryListProvider list) {
    return Column(
      children: <Widget>[
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
        Container(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: valorCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Valor',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: ListTile(
            title: DropdownButtonFormField<EntryCategory>(
              value: categoria,
              items: entryCatProvider.categories
                  .map<DropdownMenuItem<EntryCategory>>((e) {
                return DropdownMenuItem<EntryCategory>(
                  child: Text(e.name),
                  value: e,
                );
              }).toList(),
              onChanged: (EntryCategory? newValue) {
                setState(() {
                  categoria = newValue;
                });
              },
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('Guardar'),
          onPressed: () {
            Entry newPennd = save();
            list.insertEntry(newPennd);
            Navigator.pushReplacementNamed(context, 'list_entries');
          },
        ),
      ],
    );
  }

  String validatePassword(String? value) {
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return '';
  }

  String? validateMobile(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value?.length == 0) {
      return "El telefono es necesario";
    } else if (value?.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return null;
  }

  String? validateNumber(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value?.length == 0) {
      return "El valor es necesario";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value != null) {
      return null;
    }
    return "El nombre es necesario";
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!(value != null)) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  save() {
    if (keyForm.currentState!.validate()) {
      print("Nombre ${nameCtrl.text}");
      print("Valor ${valorCtrl.text}");
      print("Categoria $categoria");
      keyForm.currentState!.reset();
      Entry newEntry = new Entry();
      newEntry.category = categoria?.name ?? '';
      print(valorCtrl.text.runtimeType);
      print(valorCtrl.text);
      newEntry.value = int.parse(valorCtrl.text.trim());
      newEntry.name = nameCtrl.text;

      return newEntry;
    }
  }
}
