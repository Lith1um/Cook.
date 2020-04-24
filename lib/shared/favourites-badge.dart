import 'package:flutter/material.dart';

class FavouritesBadge extends StatelessWidget {
  final int favourites;

  FavouritesBadge({this.favourites});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            favourites > 0 ? Icons.favorite : Icons.favorite_border,
            color: favourites > 0 ? Colors.red : Colors.grey[350],
            size: 18.0,
          ),
          SizedBox(width: 5.0),
          Text(favourites.toString()),
        ]
      )
    );
  }
}