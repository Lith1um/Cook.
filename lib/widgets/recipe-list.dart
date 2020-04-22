// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/shared/loading.dart';
import 'package:cook/widgets/recipe-tile.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipeList extends StatelessWidget {
  
  final Stream recipesStream;

  const RecipeList({@required this.recipesStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: recipesStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        return ListView.separated(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => RecipeTile(
            recipe: Recipe.fromJson(snapshot.data.documents[index].data),
            documentReference: snapshot.data.documents[index].reference
          ),
          separatorBuilder: (context, index) => Divider(thickness: 1.0,),
        );
      },
    );
  }
}
