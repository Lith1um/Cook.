// Libs
import 'package:cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:cook/screens/authenticate/authenticate.dart';

// Models
import 'package:cook/models/user.dart';

class ProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    if (user == null) {
      return Authenticate();
    } else {
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
}
