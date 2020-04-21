// Libs
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Models
import 'package:cook/models/user.dart';

class MemberFeature extends StatelessWidget {

  final Widget content;

  MemberFeature({this.content});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    if (user == null) {
      // Feature disabled screen
      return SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.0,
                child: Image.asset('assets/images/logo.png', fit: BoxFit.fitWidth)
              ),
              SizedBox(height: 24.0),
              Container(
                width: 200.0,
                child: Text(
                  'This feature is disabled',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18.0
                  )
                )
              ),
              SizedBox(height: 12.0),
              Container(
                width: 200.0,
                child: Text(
                  'Please log in or sign up for an account on the \'profile\' tab to acsess this feature',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.grey[600]
                  )
                ),
              )
            ]
          )
        )
      );
    } else {
      // show intended content
      return content;
    }
  }
}
