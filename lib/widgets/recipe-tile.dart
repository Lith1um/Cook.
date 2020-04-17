// Libs
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Pages
import 'package:cook/pages/recipe-page.dart';

// Widgets
import 'package:cook/widgets/ink-wrapper.dart';
import 'package:cook/widgets/reviews-stars.dart';
import 'package:cook/widgets/tags.dart';

// Models
import 'package:cook/models/recipe.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  final DocumentReference documentReference;

  RecipeTile({@required this.recipe, @required this.documentReference});

  final double borderRadiusValue = 10.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: InkWrapper(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipePage(
              recipe: recipe,
              documentReference: documentReference
            ))
          );
        },
        borderRadius: BorderRadius.all(Radius.circular(borderRadiusValue)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadiusValue),
                topRight: Radius.circular(borderRadiusValue)
              ),
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          recipe.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                          ),
                        ),
                      ),
                      ReviewStars(
                        reviews: recipe.reviews,
                        score: recipe.reviewScore
                      )
                    ],
                  ),
                  if (recipe.prepTime != null) ...[
                    SizedBox(height: 2.0),
                    Text('Preparation time: ${recipe.prepTime} mins'),
                  ],
                  if (recipe.cookTime != null) ...[
                    SizedBox(height: 2.0),
                    Text('Cooking time: ${recipe.cookTime} mins'),
                  ],
                  if (recipe.cuisines != null) ...[
                    SizedBox(height: 5.0),
                    Tags(tagsText: recipe.cuisines)
                  ]
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
