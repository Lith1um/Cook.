// Libs
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Services
import 'package:cook/services/recipe-delete.dart';

// Widgets
import 'package:cook/shared/ink-wrapper.dart';
import 'package:cook/shared/reviews-stars.dart';

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
    print('setFavourite');
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
      // appBar: AppBar(
      //   title: Text(widget.recipe.name),
      //   actions: <Widget>[
      //     Builder(builder: (context) =>
      //       IconButton(
      //         icon: Icon(
      //           _favourite ? Icons.favorite : Icons.favorite_border,
      //           color: _favourite ? Colors.red[600] : Colors.white
      //         ),
      //         onPressed: setFavourite
      //       )
      //     ),
      //     PopupMenuButton(
      //       itemBuilder: (BuildContext context) {
      //         return _menuOptions.map((String option) {
      //           return PopupMenuItem(
      //             value: option,
      //             child: Text(
      //               option,
      //               style: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 color: option == 'Delete' ? Colors.red : Colors.black
      //               ),
      //             ),
      //           );
      //         }).toList();
      //       },
      //       onSelected: onMenuOptionSelected,
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
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
                          padding: EdgeInsets.all(20.0),
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
                              fontSize: 18.0
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
                      Text('Total time: ${widget.recipe.prepTime + widget.recipe.cookTime} mins'),
                      ReviewStars(
                        reviews: widget.recipe.reviews,
                        score: widget.recipe.reviewScore,
                        size: 16.0,
                      )
                    ]
                  ),
                ),
                SizedBox(height: 50.0)
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
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: InkWrapper(
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
                ),
              )
            ),
          ]
        ),
      )
    );
  }
}