// Libs
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:cook/screens/home/home.dart';

// Services
import 'package:cook/services/auth.dart';

// Models
import 'package:cook/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Cook.',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
