// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/shared/loading.dart';
import 'package:cook/shared/recipe-tile.dart';
import 'package:cook/shared/no-results.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipeList extends StatelessWidget {
  
  final Stream recipesStream;
  final IconData noResultsIcon;
  final String noResultsTitle;
  final String noResultsMessage;

  const RecipeList({
    @required this.recipesStream,
    this.noResultsIcon = Icons.book,
    this.noResultsTitle = 'There\'s nothing here...',
    this.noResultsMessage = 'Looks like we couldn\'t find anything matching that search, try searching for something else or browse all recipes',
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: recipesStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        if (snapshot.data.documents.length == 0) 
          return NoResults(
            icon: noResultsIcon,
            title: noResultsTitle,
            message: noResultsMessage,
          );
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) => RecipeTile(
            recipe: Recipe.fromJson(snapshot.data.documents[index].data),
            documentReference: snapshot.data.documents[index].reference
          ),
        );
      },
    );
  }
}
