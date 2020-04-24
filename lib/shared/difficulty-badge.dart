import 'package:flutter/material.dart';

class DifficultyBadge extends StatelessWidget {
  final String difficulty;

  DifficultyBadge({this.difficulty});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.poll,
            color: Colors.orange,
            size: 18.0,
          ),
          SizedBox(width: 5.0),
          Text(difficulty),
        ]
      )
    );
  }
}