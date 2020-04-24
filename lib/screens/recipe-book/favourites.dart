// Libs
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services
import 'package:cook/services/recipes.dart';

// Widgets
import 'package:cook/shared/recipe-list.dart';

// Models
import 'package:cook/models/user.dart';

class Favourites extends StatelessWidget {
  final RecipesService _recipesService = RecipesService();

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);

    return RecipeList(
      recipesStream: _recipesService.getFavouritesForUser(user.uid),
      noResultsIcon: Icons.favorite_border,
      noResultsTitle: 'There\'s nothing here...',
      noResultsMessage: 'You haven\'t added any recipes to your favourites yet, head over to the browse tab and save some tasty looking food!',
    );
  }
}