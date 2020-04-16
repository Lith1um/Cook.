// Libs
import 'package:cook/models/recipe.dart';
import 'package:cook/widgets/recipe-tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('recipes').orderBy('name').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => RecipeTile(
            recipe: Recipe.fromJson(snapshot.data.documents[index].data)
          ),
        );
      },
    );
  }
}