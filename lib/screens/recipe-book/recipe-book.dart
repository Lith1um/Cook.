// Libs
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:cook/screens/recipe-book/favourites.dart';

// Services
import 'package:cook/services/recipes.dart';

// Widgets
import 'package:cook/widgets/recipe-list.dart';

// Models
import 'package:cook/models/user.dart';

class RecipeBook extends StatelessWidget {

  static final RecipesService _recipesService = RecipesService();

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);

    return SafeArea(
      child: RecipeList(
        recipesStream: _recipesService.getRecipesForUser(user.uid)
      )
    );
  }
}
