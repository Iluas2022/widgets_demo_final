import 'package:flutter/material.dart';
import 'contacts.dart';
import 'users.dart';
import 'authorization.dart';
import 'registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Загрузка информации',
        initialRoute: '/',
        routes: {
          '/': (context) => Authorization(),
          '/ registration': (context) => const Registration(),
          '/ contacts': (context) => const Contacts(),
          '/ users': (context) => Users(),
        });
  }
}
