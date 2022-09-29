import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/pages/home.dart';
import 'package:proyecto_prquitectura/pages/list_spents_page.dart';
import 'package:proyecto_prquitectura/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Titulo',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => Home(),
        'list_spents': (_) => ListSpents(),
        'list_entries': (_) => List
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey),
    );
  }
}
