import 'package:flutter/material.dart';

class TextList extends StatelessWidget {

  final List<dynamic> textList;
  final bool numberedList;
  final double spacing;
  final TextStyle style;
  final Function onDelete;

  TextList(
    this.textList,
    {
      this.numberedList = false,
      this.spacing = 1.0,
      this.style,
      this.onDelete
    }
  );

  String getPoint(int index) {
    return numberedList ? '${index+1}.' : '\u2022';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(textList.length, (index) =>
        Padding(
          padding: EdgeInsets.symmetric(vertical: spacing),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  ' ${getPoint(index)} ${textList[index].toString()}',
                  style: style
                ),
              ),
              if (onDelete != null)
                Container(
                  height: 32.0,
                  width: 48.0,
                  child: IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.clear),
                    color: Colors.red,
                    iconSize: 24.0,
                    onPressed: () => onDelete(index)
                  )
                )
            ],
          )
        )
      )
    );
  }
}