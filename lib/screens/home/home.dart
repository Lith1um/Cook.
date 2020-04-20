// Libs
import 'package:flutter/material.dart';

// Screens
import 'package:cook/screens/new-recipe-page.dart';

// Services
import 'package:cook/services/auth.dart';

// Widgets
import 'package:cook/widgets/recipe-list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cook.',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            label: Text('logout', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await _auth.signOut();
            }
          )
        ],
      ),
      body: RecipeList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewRecipePage())
          );
        },
        tooltip: 'Add Recipe',
        child: Icon(Icons.add),
      ),
    );
  }
}
