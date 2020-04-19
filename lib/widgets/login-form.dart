import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Username'
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _passwordController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 10.0),
          FlatButton(
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.blueGrey[700]
              ),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.pushNamed(context, '/home');
              }
            }
          )
        ]
      )
    );
  }
}