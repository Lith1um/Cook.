// Libs
import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 60.0,
            color: Colors.blueGrey[700],
          ),
          SizedBox(height: 12.0),
          Container(
            width: 200.0,
            child: Text(
              'There\'s nothing here...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey[700],
                fontSize: 18.0
              )
            )
          ),
          SizedBox(height: 12.0),
          Container(
            width: 200.0,
            child: Text(
              'You haven\'t added any recipes to your favourites yet, head over to the browse tab and save some tasty looking food!',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.blueGrey[700]
              )
            ),
          )
        ]
      )
    );
  }
}