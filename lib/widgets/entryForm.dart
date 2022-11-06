import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<EntryListProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nuevo Ingreso'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
              icon: Icon(Icons.arrow_back_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(60.0),
            child: Form(
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

  String? categoria = '';

  Widget formUI(EntryListProvider list) {
    const List<String> listCateg = <String>[
      "Transporte",
      "Servicios",
      "Gustico",
      "Comida"
    ];

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
        formItemsDesign(
            Icons.attach_money,
            TextFormField(
              controller: valorCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
              validator: validateNumber,
            )),
        formItemsDesign(
            Icons.abc,
            Column(children: <Widget>[
              Text("Categoria"),

              // RadioListTile<String>(
              //   title: Text('Comida'),
              //   value: 'Comida',
              //   groupValue: categoria,
              //   onChanged: (value) {
              //     setState(() {
              //       categoria = value;
              //     });
              //   },
              // ),
              // RadioListTile<String>(
              //   title: const Text('Transporte'),
              //   value: 'Transporte',
              //   groupValue: categoria,
              //   onChanged: (value) {
              //     setState(() {
              //       categoria = value;
              //     });
              //   },
              // ),
              // RadioListTile<String>(
              //   title: const Text('Otros'),
              //   value: 'Otros',
              //   groupValue: categoria,
              //   onChanged: (value) {
              //     setState(() {
              //       categoria = value;
              //     });
              //   },
              // )

              DropdownButton<String>(
                icon: const Icon(Icons.arrow_downward),
                style: const TextStyle(
                    color: Color(0xFF03A0FE),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                items: listCateg.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    categoria = value;
                  });
                },
              ),
            ])),
        GestureDetector(
            onTap: () {
              Entry newPennd = save();
              list.insertEntry(newPennd);
              Navigator.pushReplacementNamed(context, 'list_entries');
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
      newEntry.category = categoria!;
      newEntry.value = int.parse(valorCtrl.text);
      newEntry.name = nameCtrl.text;

      return newEntry;
    }
  }
}
