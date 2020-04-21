// Libs
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/auth.dart';

class Profile extends StatelessWidget {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlatButton.icon(
        icon: Icon(Icons.exit_to_app),
        label: Text('logout'),
        onPressed: () async {
          await _auth.signOut();
        }
      )
    );
  }
}
