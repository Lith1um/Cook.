// Libs
import 'package:cook/shared/list-searchbar.dart';
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/shared/loading.dart';
import 'package:cook/shared/recipe-tile.dart';
import 'package:cook/shared/no-results.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipeList extends StatefulWidget {

  final Stream recipesStream;
  final String title;
  final IconData noResultsIcon;
  final String noResultsTitle;
  final String noResultsMessage;

  const RecipeList({
    @required this.recipesStream,
    this.title = 'Cook.',
    this.noResultsIcon = Icons.book,
    this.noResultsTitle = 'There\'s nothing here...',
    this.noResultsMessage = 'Looks like we couldn\'t find anything matching that search, try searching for something else or browse all recipes',
  });

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  
  String _searchTerm = '';

  void _triggerSearch(String searchValue) {
    setState(() => _searchTerm = searchValue);
  }

  List<Map<String, dynamic>> _getFilteredRecipes(snapshotDoc) {
    List<Map<String, dynamic>> recipes = [];
    for (var recipe in snapshotDoc) {
      recipes.add({
        'recipe': Recipe.fromJson(recipe.data),
        'docRef': recipe.reference
      });
    }

    if (_searchTerm == '') return recipes;

    return recipes.where((document) {
      return document['recipe'].name.toLowerCase().contains(_searchTerm.toLowerCase())
        || document['recipe'].tags != null && document['recipe'].tags.toLowerCase().contains(_searchTerm.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListSearchbar(
            title: widget.title,
            onSearch: _triggerSearch
          ),
          Expanded(
            child: StreamBuilder(
              stream: widget.recipesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Loading();
                
                List<Map<String, dynamic>> recipes =
                  _getFilteredRecipes(snapshot.data.documents);

                if (recipes.length == 0)
                  return NoResults(
                    icon: widget.noResultsIcon,
                    title: widget.noResultsTitle,
                    message: widget.noResultsMessage,
                  );

                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 0.0),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) => RecipeTile(
                    recipe: recipes[index]['recipe'],
                    documentReference: recipes[index]['docRef']
                  ),
                );
              },
            )
          )
        ]
    );
  }
}
