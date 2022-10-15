import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/pages/pages.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/services/auth_service.dart';
import 'package:proyecto_prquitectura/widgets/entryForm.dart';
import 'package:proyecto_prquitectura/widgets/test.dart';

void main() {
  runApp(const AppState());
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
        ChangeNotifierProvider(
          create: (_) => EntryListProvider(),
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
      initialRoute: 'login',
      routes: {
        'login':(_) => LoginPage(),
        'register': (_) => RegisterPage(),
        'home': (_) => Home(),
        'list_spents': (_) => ListSpents(),
        'list_entries': (_) => ListEntries(),
        'new_spent': (_) => SpendForm(),
        'test': (_) => SpendForm(),
        'new_entry': (_) => EntryForm(),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey),
    );
  }
}
