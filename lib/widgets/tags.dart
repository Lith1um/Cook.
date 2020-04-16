// Libs
import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  final String tagsText;

  Tags({@required this.tagsText});

  List<Widget> getTags() {
    List<String> tagTextList = tagsText.split(',')
      .where((tag) => tag.trim() != '')
      .map((tag) => tag.trim()).toList();
    List<Widget> tags = [];

    for (String tag in tagTextList ) {
      tags.add(
        Container(
          margin: EdgeInsets.only(right: 8.0, bottom: 5.0),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(20.0),
            color: Colors.blue
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: Colors.white
            ),
          )
        )
      );
    }

    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: getTags()
    );
  }
}
