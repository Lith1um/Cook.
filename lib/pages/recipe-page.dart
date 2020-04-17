// Libs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook/services/recipe-delete.dart';
import 'package:cook/widgets/reviews-stars.dart';
import 'package:flutter/material.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final DocumentReference documentReference;

  RecipePage({@required this.recipe, @required this.documentReference});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _menuOptions = [
    'Edit',
    'Delete'
  ];

  bool _favourite = false;

  void setFavourite() {
    setState(() => _favourite = !_favourite);

    final snackBar = SnackBar(
      content: Text(_favourite
        ? 'Added to favourites' : 'Removed from favourites'),
    );

    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void onMenuOptionSelected(String option) {
    if (option == 'Delete') {
      showDialog(
        context: _scaffoldKey.currentContext,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Text("Are you sure you want to delete this recipe?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                ),
              ),
              onPressed: () async {
                await deleteRecipe(widget.documentReference);
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            )
          ],
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.recipe.name),
        actions: <Widget>[
          Builder(builder: (context) =>
            IconButton(
              icon: Icon(
                _favourite ? Icons.star : Icons.star_border
              ),
              onPressed: setFavourite
            )
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return _menuOptions.map((String option) {
                return PopupMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: option == 'Delete' ? Colors.red : Colors.black
                    ),
                  ),
                );
              }).toList();
            },
            onSelected: onMenuOptionSelected,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.recipe.imageUrl,
              fit: BoxFit.fitWidth
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ReviewStars(
                  reviews: widget.recipe.reviews,
                  score: widget.recipe.reviewScore,
                  size: 22.0,
                )
              ]
            )
          ]
        ),
      ),
    );
  }
}