// Libs
import 'package:flutter/material.dart';

// Screens
import 'package:cook/screens/authenticate/sign_in.dart';
import 'package:cook/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              child: TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              tabs: <Widget>[
                Tab(text: 'Login'),
                Tab(text: 'Sign up'),
              ]
            ),
          )
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SignIn(),
              Register()
            ],
          )
        )
      )
    );
  }
}
