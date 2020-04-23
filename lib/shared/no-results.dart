import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {

  final IconData icon;
  final String title;
  final String message;

  const NoResults({
    @required this.icon,
    @required this.title,
    this.message
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60.0,
            color: Colors.blueGrey[500],
          ),
          SizedBox(height: 12.0),
          Container(
            width: 200.0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey[700],
                fontSize: 18.0
              )
            )
          ),
          SizedBox(height: 12.0),
          if (message != null)
            Container(
              width: 200.0,
              child: Text(
                message,
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