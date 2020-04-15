// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/widgets/recipe-form.dart';

class NewRecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Recipe',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SafeArea(
        child: RecipeForm(),
      )
    );
  }
}