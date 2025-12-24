import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/add_person.dart';
import 'screens/update_person.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/accueil',
      routes: {
        // '/connexion': (context) => ConnexionPage(),
        // '/inscription': (context) => InscriptionPage(),
        '/accueil': (context) => HomeScreen(),
        '/ajouter': (context) => AddPersonScreen(),
        '/modifier': (context) => ModifierContactPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
