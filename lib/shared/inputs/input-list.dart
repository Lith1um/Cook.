import 'package:cook/shared/text-list.dart';
import 'package:flutter/material.dart';

class InputList extends StatefulWidget {
  
  final String label;
  final bool numberedList;
  final Function onValueChanged;

  InputList({
    Key key,
    @required this.label,
    this.numberedList = false,
    @required this.onValueChanged
  }) : super(key: key);
  
  @override
  InputListState createState() => InputListState();
}

class InputListState extends State<InputList> {
  
  final _controller = TextEditingController();
  List<String> _textList = [];

  void reset() {
    setState(() => _textList = []);
    widget.onValueChanged(_textList);
    _controller.text = '';
  }

  void onAddButtonPressed() {
    if (_controller.text.length > 0) {
      setState(() => _textList.add(_controller.text));
      widget.onValueChanged(_textList);
      _controller.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 18.0
            )
          ),
          SizedBox(height: 5.0),
          if (_textList.length > 0)
            TextList(
              _textList,
              style: TextStyle(
                fontSize: 16.0
              ),
              numberedList: widget.numberedList,
              onDelete: (int index) {
                setState(() => _textList.removeAt(index));
                widget.onValueChanged(_textList);
              }
            ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'add something!',
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: onAddButtonPressed
              )
            ],
          )
        ]
      )
    );
  }
}