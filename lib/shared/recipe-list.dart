// Libs
import 'package:cook/shared/ink-wrapper.dart';
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
    return Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/main-topbar.png'),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth
              )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Cook.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0
                        ),
                      ),
                      InkWrapper(
                        borderRadius: BorderRadius.circular(40.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: 28.0
                          ),
                          onPressed: () {},
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0)
                  )
                ),
              ]
            )
          ),
          Expanded(
            child: StreamBuilder(
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
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) => RecipeTile(
                    recipe: Recipe.fromJson(snapshot.data.documents[index].data),
                    documentReference: snapshot.data.documents[index].reference
                  ),
                );
              },
            )
          )
        ]
    );
  }
}
