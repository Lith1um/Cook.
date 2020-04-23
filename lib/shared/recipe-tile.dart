// Libs
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:cook/screens/recipe/recipe-page.dart';

// Widgets
import 'package:cook/shared/ink-wrapper.dart';
import 'package:cook/shared/reviews-stars.dart';
import 'package:cook/shared/tags.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  final DocumentReference documentReference;

  RecipeTile({@required this.recipe, @required this.documentReference});

  final double borderRadiusValue = 10.0;

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
        padding: EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: CachedNetworkImage(
                    imageUrl: recipe.imageUrl,
                    fit: BoxFit.fitWidth
                  ),
                ),
                SizedBox(height: 4.0),
                ReviewStars(
                  reviews: recipe.reviews,
                  score: recipe.reviewScore
                )
              ],
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    ),
                  ),
                  if (recipe.prepTime != null) ...[
                    SizedBox(height: 2.0),
                    Text('Preparation time: ${recipe.prepTime} mins'),
                  ],
                  if (recipe.cookTime != null) ...[
                    SizedBox(height: 2.0),
                    Text('Cooking time: ${recipe.cookTime} mins'),
                  ],
                  if (recipe.tags != null) ...[
                    SizedBox(height: 5.0),
                    Tags(
                      tagsText: recipe.tags,
                      size: 12.0,
                    )
                  ]
                ]
              )
            )
          ],
        )
      )
    );
  }
}
