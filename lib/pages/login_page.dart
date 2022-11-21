import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/services/auth.dart';
import 'package:proyecto_prquitectura/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String _title = 'FinTech';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text(_title)),
      body: LoginForm(),
      backgroundColor: Colors.white,
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final authService = Provider.of<AuthService2>(context);
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
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(fontSize: 20),
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
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              obscureText: true,
              validator: (value) {
                if (value != null && value.length >= 8) {
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
          TextButton(
            onPressed: () {},
            child: const Text(
              'Olvidaste tu contraseña',
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
          ),
          Row(
            children: <Widget>[
              const Text('No tienes una cuenta?'),
              TextButton(
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'register');
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          ElevatedButton(
            onPressed: () async {
              AuthService().singInWithGoogle();
            },
            child: Text("Inicia con Google !!"),
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
