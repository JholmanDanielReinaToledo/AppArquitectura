import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/pages/home.dart';
import 'package:proyecto_prquitectura/pages/list_entries_page.dart';
import 'package:proyecto_prquitectura/pages/list_spend_category.dart';
import 'package:proyecto_prquitectura/pages/list_spents_page.dart';
import 'package:proyecto_prquitectura/pages/new_spend_cagetory.dart';
import 'package:proyecto_prquitectura/pages/new_spent_page.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';
import 'package:proyecto_prquitectura/providers/spend_form_provider.dart';
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
          create: (_) => SpendCategoriesListProvider(),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Titulo',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginPage(),
        'register': (_) => RegisterPage(),
        'home': (_) => Home(),
        'list_spents': (_) => ListSpents(),
        'list_entries': (_) => ListEntries(),
        'new_spent': (_) => SpendForm(),
        'test': (_) => SpendForm(),
        'list_spend_categories': (_) => ListSpendCategories(),
        'new_spend_category': (_) => SpendCategoryForm(),
        'new_entry': (_) => EntryForm(),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey),
    );
  }
}
