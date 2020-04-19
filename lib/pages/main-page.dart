import 'package:cook/widgets/login-form.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final Function callback;

  const MainPage({this.callback});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    child: Image.asset('assets/images/logo.png', fit: BoxFit.fitWidth)
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'Cook.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                      fontSize: 32.0
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              LoginForm(callback: widget.callback)
            ]
          )
        )
      ) 
    );
  }
}
