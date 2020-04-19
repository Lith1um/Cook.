// Libs
import 'package:flutter/material.dart';

// Pages
import 'package:cook/pages/main-page.dart';
import 'package:cook/pages/home-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loggedIn = false;

  void toggleLogin(bool loggedIn) {
    setState(() => _loggedIn = loggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cook.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => _loggedIn ? HomePage(callback: toggleLogin,) : MainPage(callback: toggleLogin,)
      }
    );
  }
}
