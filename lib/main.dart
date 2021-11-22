import 'package:app_examen/create_page.dart';
import 'package:app_examen/principal_page.dart';
import 'package:app_examen/update_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (_) => PrincipalPage(),
        '/create': (_) => CreatePage(),
        '/update': (_) => UpdatePage(),
      },
      home: PrincipalPage(),
    );
  }
}
