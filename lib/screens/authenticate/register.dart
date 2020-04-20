// Libs
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 4),
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
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email should not be blank.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password should not be blank.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  FlatButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blueGrey[700]
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        
                      }
                    }
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
