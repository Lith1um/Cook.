// Libs
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/auth.dart';

// Widgets
import 'package:cook/shared/loading.dart';

// Models
import 'package:cook/models/user.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _signInError = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading ? Loading() : SingleChildScrollView(
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
                      labelText: 'Email Address'
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
                      'Login',
                      style: TextStyle(
                        color: Colors.blueGrey[700]
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // close keyboard if validated
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _loading = true;
                          _signInError = '';
                        });

                        dynamic result = await _auth.signInWithEmailPassword(
                          _usernameController.text,
                          _passwordController.text
                        );
                        if (!(result is User)) {
                          setState(() {
                            _loading = false;
                            _signInError = result;
                          });
                        }
                      }
                    }
                  ),
                  SizedBox(height: 12.0),
                  Text(_signInError, style: TextStyle(color: Colors.red, fontSize: 14.0))
                ]
              )
            )
          ]
        )
      )
    );
  }
}
