import 'package:flutter/material.dart';

class TimeBadge extends StatelessWidget {
  final int time;

  TimeBadge({this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.timelapse,
            color: Colors.blue[800],
            size: 18.0,
          ),
          SizedBox(width: 5.0),
          Text('$time mins'),
        ]
      )
    );
  }
}