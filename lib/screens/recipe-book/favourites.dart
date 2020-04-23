// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/shared/no-results.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoResults(
      icon: Icons.favorite_border,
      title: 'There\'s nothing here...',
      message: 'You haven\'t added any recipes to your favourites yet, head over to the browse tab and save some tasty looking food!',
    );
  }
}