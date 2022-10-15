import 'package:flutter/material.dart';
 
 
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
 
  static const String _title = 'FinTech';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: RegisterForm(),
        backgroundColor: Colors.white,
      );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}
 
class _RegisterFormState extends State<RegisterForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Form(

      autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'FinTech',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 20),
                )),


            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if(value != null && value.length >= 3){
                    return null;
                  }
                  return 'Ingrese un nombre valido';
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: validateEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Correo',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if(value != null && value.length >= 7){
                    return null;
                  }
                  return 'Ingrese un telefono valido';
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'telefono',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if(value != null && value.length >= 8){
                    return null;
                  }
                  return 'La contraseña debe contener minimo 8 caracteristicas';
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
            ),

            SizedBox(
              height: 40,
            ),

            
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Registrarse'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Ya tienes una cuenta?'),
                TextButton(
                  child: const Text(
                    'Iniciar Sesion',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
    );
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

  

}

