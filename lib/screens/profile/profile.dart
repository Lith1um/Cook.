// Libs
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/auth.dart';

// Models
import 'package:cook/models/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);

    return SafeArea(
      child: Column(
        children: [
          if (!user.isVerified)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Account is not verified'),
                RaisedButton(
                  onPressed: () => _auth.verifyEmailAddress(),
                  child: Text('resend email')
                )
              ]
            ),
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            }
          )
        ]
      )
    );
  }
}
