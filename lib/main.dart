import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/pages/home.dart';
import 'package:proyecto_prquitectura/pages/list_entries_page.dart';
import 'package:proyecto_prquitectura/pages/list_spents_page.dart';
import 'package:proyecto_prquitectura/pages/new_spent_page.dart';
import 'package:proyecto_prquitectura/providers/spend_form_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/services/auth_service.dart';
import 'package:proyecto_prquitectura/widgets/test.dart';

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
        ChangeNotifierProvider(
          create: (_) => SpentListProvider(),
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
      initialRoute: 'test',
      routes: {
        'home': (_) => Home(),
        'list_spents': (_) => ListSpents(),
        'list_entries': (_) => ListEntries(),
        'new_spent': (_) => NewSpentPage(),
        'test': (_) => TestForm(),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey),
    );
  }
}
