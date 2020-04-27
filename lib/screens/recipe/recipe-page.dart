// Libs
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/recipes.dart';

// Widgets
import 'package:cook/shared/tags.dart';
import 'package:cook/shared/ink-wrapper.dart';
import 'package:cook/shared/favourites-badge.dart';
import 'package:cook/shared/difficulty-badge.dart';
import 'package:cook/shared/time-badge.dart';
import 'package:cook/screens/recipe/item-list.dart';

// Models
import 'package:cook/models/recipe.dart';
import 'package:cook/models/user.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  final DocumentReference documentReference;
  final User user;

  RecipePage({@required this.recipe, @required this.documentReference, @required this.user});

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final RecipesService _recipesService = RecipesService();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _favourite;

  @override
  void initState() {
    _favourite = widget.user != null ? widget.recipe.favourites.contains(widget.user.uid)
      : false;
    super.initState();
  }

  void setFavourite() async {
    _favourite ? await _recipesService.removeFavourite(widget.documentReference, widget.user.uid)
      : await _recipesService.addFavourite(widget.documentReference, widget.user.uid);

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
                await _recipesService.deleteRecipe(widget.documentReference);
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/main-backdrop.png', scale: 5.0),
            alignment: Alignment.topLeft,
            repeat: ImageRepeat.repeat
          )
        ),
        child:SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: widget.recipe.imageUrl,
                        fit: BoxFit.fitHeight
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30.0),
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0)
                              )
                            ),
                            child: Text(
                              widget.recipe.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                          )
                        )
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          spreadRadius: -1.0,
                          offset: Offset(0.0, 4.0),
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeBadge(time: widget.recipe.prepTime + widget.recipe.cookTime),
                        DifficultyBadge(difficulty: widget.recipe.difficulty),
                        FavouritesBadge(favourites: widget.recipe.favourites.length)
                      ]
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(30.0),
                    padding: EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.recipe.description != null && widget.recipe.description != '') ...[
                          Text(widget.recipe.description, textAlign: TextAlign.justify),
                          SizedBox(height: 20.0),
                        ],
                        Text(
                          'Ingredients',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                          )
                        ),
                        SizedBox(height: 10.0),
                        ItemList(widget.recipe.ingredients),
                        SizedBox(height: 20.0),
                        Text(
                          'Steps',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                          )
                        ),
                        SizedBox(height: 10.0),
                        ItemList(widget.recipe.steps, numberedList: true),
                        if (widget.recipe.tags != null) ...[
                          SizedBox(height: 20.0),
                          Text(
                            'Tags',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                            )
                          ),
                          SizedBox(height: 10.0),
                          Tags(tagsText: widget.recipe.tags, size: 16.0,),
                        ]
                      ]
                    )
                  )
                ]
              ),
              SafeArea(
                child: InkWrapper(
                  borderRadius: BorderRadius.circular(60.0),
                  child: Container(
                    height: 60.0,
                    width: 60.0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 28.0,
                      color: Colors.white,
                      onPressed: () {}
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              if (widget.user != null)
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        InkWrapper(
                          borderRadius: BorderRadius.circular(60.0),
                          child: Container(
                            height: 60.0,
                            width: 60.0,
                            child: IconButton(
                              icon: Icon(
                                _favourite ? Icons.favorite : Icons.favorite_border,
                                color: _favourite ? Colors.red[600] : Colors.white
                              ),
                              iconSize: 28.0,
                              color: Colors.white,
                              onPressed: () {}
                            ),
                          ),
                          onTap: setFavourite,
                        )
                      ]
                    )
                  )
                ),
            ]
          ),
        )
      )
    );
  }
}