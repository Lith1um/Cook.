// Libs
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: RaisedButton(
            child: Text('Sign in anonymously'),
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if(result == null){
                print('error signing in');
              } else {
                print('signed in');
                print(result.uid);
              }
            },
          )
        )
      )
    );
  }
}
