// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/widgets/recipe-list.dart';
import 'package:cook/pages/new-recipe-page.dart';

class HomePage extends StatelessWidget {
  final Function callback;

  const HomePage({this.callback});

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
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => callback(false),
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
