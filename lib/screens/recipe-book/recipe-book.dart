// Libs
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services
import 'package:cook/services/recipes.dart';

// Widgets
import 'package:cook/shared/recipe-list.dart';

// Models
import 'package:cook/models/user.dart';

class RecipeBook extends StatelessWidget {

  static final RecipesService _recipesService = RecipesService();

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);

    return RecipeList(
      recipesStream: _recipesService.getRecipesForUser(user.uid),
      noResultsMessage: 'You haven\'t uploaded any of your own recipes to your favourites yet, head over to the add tab and let everyone know what you made!',
    );
  }
}
