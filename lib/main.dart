import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_prquitectura/pages/list_entry_category.dart';
import 'package:proyecto_prquitectura/pages/list_spend_category.dart';
import 'package:proyecto_prquitectura/pages/new_entry_cagetory.dart';
import 'package:proyecto_prquitectura/pages/new_spend_cagetory.dart';
import 'package:proyecto_prquitectura/providers/entries_categories_list.dart';
import 'package:proyecto_prquitectura/providers/spend_categories_list.dart';
import 'package:proyecto_prquitectura/pages/pages.dart';
import 'package:proyecto_prquitectura/providers/entries_list_provider.dart';
import 'package:proyecto_prquitectura/providers/spent_list_provider.dart';
import 'package:proyecto_prquitectura/services/auth.dart';
import 'package:proyecto_prquitectura/services/auth_service.dart';
import 'package:proyecto_prquitectura/widgets/entryForm.dart';
import 'package:proyecto_prquitectura/widgets/test.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SpentListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SpendCategoriesListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EntryListProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EntryCategoriesListProvider(),
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
      home: AuthService().handleAuthState(),
      routes: {
        'login': (_) => LoginPage(),
        'register': (_) => RegisterPage(),
        'home': (_) => Home(),
        'list_spents': (_) => ListSpents(),
        'list_entries': (_) => ListEntries(),
        'new_spent': (_) => SpendForm(),
        'test': (_) => SpendForm(),
        'list_spend_categories': (_) => ListSpendCategories(),
        'list_entry_categories': (_) => ListEntryCategories(),
        'new_spend_category': (_) => SpendCategoryForm(),
        'new_entry_category': (_) => EntryCategoryForm(),
        'new_entry': (_) => EntryForm(),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey),
    );
  }
}
