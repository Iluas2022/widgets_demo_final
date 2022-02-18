import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authorization extends StatefulWidget {
  Authorization({Key? key}) : super(key: key);

  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LoginForm(),
    );
  }

  void _validation() async {
    final prefs = await SharedPreferences.getInstance();
    var _summ = _loginController.text + _passwordController.text;
    //int password=
    if (prefs.getInt('password') == _passwordController.text.hashCode) {
      if (_summ.hashCode == prefs.getInt('login')) {
        Navigator.pushNamed(context, '/ contacts');
      }
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Неверно'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Регистрация'),
                onPressed: () {
                  Navigator.pushNamed(context, '/ registration');
                },
              ),


              TextButton(
                child: const Text('Закрыть'),
                onPressed: () => exit(0),
              ),
            ],
          );
          },
        );
     }
  }

  Widget _LoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: ListView(
          children: [
            const SizedBox(
              height: 60,
            ),


            const Text(
              'Приветствуем!',
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),


            const SizedBox(
              height: 60,
            ),


            TextFormField(
              controller: _loginController,
              decoration: const InputDecoration(
                icon: Icon(Icons.login),
                labelText: 'Логин',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.black, width: 4)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.green, width: 4)),
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? val) =>
                  val!.isEmpty ? 'Заполните поле Логин' : null,
               ),
            SizedBox(
              height: 50,
            ),


            TextFormField(
              controller: _passwordController,
              obscureText: _hidePass,
              maxLength: 4,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.black, width: 4)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.black87, width: 4)),
                icon: Icon(Icons.password),
                labelText: 'Пароль',
              ),
            ),


            const SizedBox(
              height: 30,
            ),


            ElevatedButton(
                onPressed: () {
                  _validation();
                },
                child: const Text('Вход')),
            const SizedBox(
              height: 70,
            ),


            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
              ),


              onPressed: () {
                Navigator.pushNamed(context, '/ registration');
              },

              child: const Text('Регистрация'),
            )
          ],
          ),
        ),
      );
    }
}
