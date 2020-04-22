import 'package:flutter/material.dart';

class TextList extends StatelessWidget {

  final List<dynamic> textList;
  final bool numberedList;
  final TextStyle style;

  TextList(this.textList, {this.numberedList = false, this.style});

  String getPoint(int index) {
    return numberedList ? '${index+1}.' : '\u2022';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(textList.length, (index) =>
        Text(
          ' ${getPoint(index)} ${textList[index].toString()}',
          style: style
        ),
      )
    );
  }
}