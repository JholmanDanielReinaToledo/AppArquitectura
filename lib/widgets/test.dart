import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/common/Config.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';

class SpendForm extends StatefulWidget {
  const SpendForm({Key? key}) : super(key: key);

  @override
  _SpendFormState createState() => _SpendFormState();
}

class _SpendFormState extends State<SpendForm> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController valorCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  late EntryListProvider entryProvider;
  late SpentListProvider spendProvider;
  late SpendCategoriesListProvider spendCatProvider;
  SpendCategory? categoria;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      spendProvider = Provider.of<SpentListProvider>(context);
      entryProvider = Provider.of<EntryListProvider>(context);
      spendCatProvider = Provider.of<SpendCategoriesListProvider>(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo gasto'),
        backgroundColor: Config.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: keyForm,
            child: formUI(spendProvider),
          ),
        ),
      ),
    );
  }

  Widget formUI(SpentListProvider list) {
    print(spendCatProvider.categories.toString());
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
            validator: validateValue,
            controller: valorCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Valor',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: ListTile(
            title: DropdownButtonFormField<SpendCategory>(
              value: categoria,
              items: spendCatProvider.categories
                  .map<DropdownMenuItem<SpendCategory>>((e) {
                return DropdownMenuItem<SpendCategory>(
                  child: Text(e.name),
                  value: e,
                );
              }).toList(),
              onChanged: (SpendCategory? newValue) {
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
            Spent newPennd = save();

            if (newPennd != null) {
              list.insertSpend(newPennd);
              Navigator.pushReplacementNamed(context, 'list_spents');
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

  String validateGasto(String value) {
    return '';
  }

  String validatePassword(String? value) {
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return '';
  }

  String? validateMobile(String? value) {
    if (value?.length == 0) {
      return "El telefono es necesario";
    } else if (value?.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return null;
  }

  String? validateValue(String? value) {
    String patttern = r'^(\d|-)?(\d|,)*\.?\d*$';
    RegExp regExp = RegExp(patttern);
    if (value == null) {
      return "El valor es necesario";
    } else if (!regExp.hasMatch(value)) {
      print(regExp.hasMatch(value));
      return "Formato incorrecto";
    } else {
      if (value != null && !value.isEmpty) {
        if (int.parse(value) > (entryProvider.total - spendProvider.total)) {
          return 'El gasto excede el dinero disponible';
        }
      }
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
      Spent newSpend = new Spent();
      if (categoria?.name != null) {
        newSpend.category = categoria?.name ?? '';
      }
      try {
        newSpend.value = int.parse(valorCtrl.text);
      } catch (e) {}
      newSpend.name = nameCtrl.text;

      return newSpend;
    }
  }
}
