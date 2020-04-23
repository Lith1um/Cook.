// Libs
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:cook/screens/recipe/recipe-page.dart';

// Widgets
import 'package:cook/shared/ink-wrapper.dart';
import 'package:cook/shared/reviews-stars.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  final DocumentReference documentReference;

  RecipeTile({@required this.recipe, @required this.documentReference});

  @override
  Widget build(BuildContext context) {
    return InkWrapper(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipePage(
            recipe: recipe,
            documentReference: documentReference
          ))
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: -1.0,
                        offset: Offset(0.0, 4.0),
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: recipe.imageUrl,
                      fit: BoxFit.fitWidth
                    ),
                  )
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)
                        )
                      ),
                      child: Text(
                        recipe.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                        ),
                      ),
                    )
                  )
                )
              ]
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
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.timer, color: Colors.blue[800],),
                        SizedBox(width: 5.0),
                        Text('${recipe.prepTime + recipe.cookTime} mins'),
                      ]
                    )
                  ),
                  ReviewStars(
                    score: recipe.reviewScore,
                    size: 14.0,
                  )
                ]
              ),
            ),
          ]
        )
      )
    );
  }
}
