import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {

  final List<dynamic> itemList;
  final bool numberedList;
  final double spacing;
  final double size;

  ItemList(
    this.itemList,
    {
      this.numberedList = false,
      this.spacing = 10.0,
      this.size = 16.0
    }
  );

  Widget getPoint(int index) {
    Widget value = numberedList 
      ? Text('${index+1}', style: TextStyle(fontSize: size))
      : Icon(Icons.add, size: size);

    return Container(
      height: 32.0,
      width: 32.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: -1.0,
            offset: Offset(0.0, 3.0),
          )
        ]
      ),
      child: Center(
        child: value,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(itemList.length, (index) =>
        Padding(
          padding: EdgeInsets.symmetric(vertical: spacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getPoint(index),
              SizedBox(width: 15.0),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text(
                    '${itemList[index].toString()}',
                    style: TextStyle(fontSize: size)
                  ),
                ),
              ),
            ],
          )
        )
      )
    );
  }
}