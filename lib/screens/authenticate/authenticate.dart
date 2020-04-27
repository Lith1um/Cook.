// Libs
import 'package:flutter/material.dart';

// Screens
import 'package:cook/screens/authenticate/sign_in.dart';
import 'package:cook/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with TickerProviderStateMixin {

  static List<Widget> _tabs = <Widget>[
    Text('Log in'),
    Text('Sign up'),
  ];
  static List<Widget> _tabsContent = <Widget>[
    SignIn(),
    Register()
  ];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.0),
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
              SizedBox(height: 40.0),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Text(
                      'Cook is a free-to-use app that lets people share their creations with the world and inspire others to make something new. Click the browse tab to start searching food.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontSize: 14.0
                      )
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Alternatively, log in or sign up for access to all features including adding recipes, saving and reviewing other people\'s recipes and managing your own recipe book.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.blueGrey[700]
                      )
                    ),
                  ]
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: TabBar(
                  labelPadding: EdgeInsets.all(15.0),
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _tabController,
                  indicatorColor: Colors.blue[800],
                  labelColor: Colors.blue[800],
                  tabs: _tabs
                ),
              ),
              Container(
                height: 300.0,
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: _tabsContent,
                )
              )
            ]
          )
        )
      )
    );
  }
}
