// Libs
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/auth.dart';

// Widgets
import 'package:cook/shared/loading.dart';

// Models
import 'package:cook/models/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _registerError = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Email Address'
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Email should not be blank.';
              } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                return 'Email is not a valid format';
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
              if (value.length < 8) {
                return 'Password must be 8+ characters.';
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.blueGrey[700],
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // close keyboard if validated
                FocusScope.of(context).unfocus();
                setState(() {
                  _loading = true;
                  _registerError = '';
                });

                dynamic result = await _auth.registerWithEmailPassword(
                  _usernameController.text,
                  _passwordController.text
                );
                if (!(result is User)) {
                  setState(() {
                    _loading = false;
                    _registerError = result;
                  });
                }
              }
            }
          ),
          SizedBox(height: 12.0),
          Text(_registerError, style: TextStyle(color: Colors.red, fontSize: 14.0))
        ]
      )
    );
  }
}
