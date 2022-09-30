import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';

class SpendForm extends StatefulWidget {
  @override
  _SpendFormState createState() => _SpendFormState();
}

class _SpendFormState extends State<SpendForm> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController valorCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<SpentListProvider>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registrarse'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(60.0),
            child: Form(
              key: keyForm,
              child: formUI(),
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

  String? categoria = 'hombre';

  Widget formUI() {
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
              decoration: InputDecoration(
                labelText: 'Valor',
              ),
              validator: validateNumber,
            )),
        formItemsDesign(
            Icons.abc,
            Column(children: <Widget>[
              Text("Categoria"),
              RadioListTile<String>(
                title: Text('Comida'),
                value: 'Comida',
                groupValue: categoria,
                onChanged: (value) {
                  setState(() {
                    categoria = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Transporte'),
                value: 'Transporte',
                groupValue: categoria,
                onChanged: (value) {
                  setState(() {
                    categoria = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Otros'),
                value: 'Otros',
                groupValue: categoria,
                onChanged: (value) {
                  setState(() {
                    categoria = value;
                  });
                },
              )
            ])),
        GestureDetector(
            onTap: () {
              save();
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
    }
  }
}
