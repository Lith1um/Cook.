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

  final List<Widget> _tabs = [
    Text('Mine'),
    Text('Favourites'),
  ];

  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              labelPadding: EdgeInsets.all(15.0),
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              tabs: _tabs
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              RecipeList(recipesStream: _recipesService.getRecipesForUser(user.uid),),
              Favourites(),
            ],
          )
        )
      )
    );
  }
}
