// Libs
import 'package:flutter/material.dart';

class InputTags extends StatefulWidget {
  final String label;
  final Function onValueChanged;

  InputTags({@required this.label, @required this.onValueChanged});

  @override
  _InputTagsState createState() => _InputTagsState();
}

class _InputTagsState extends State<InputTags> {
  final _controller = TextEditingController();
  List<String> _tags = [];

  void onTagFieldChanged(String value) {
    setState(() {
      _tags = value.split(',').where((tag) => tag.replaceAll(' ', '') != '').toList();
    });
    widget.onValueChanged(_tags.join(','));
  }

  Widget getTag(String text) {
    return Container(
      margin: EdgeInsets.only(right: 8.0, bottom: 5.0),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(20.0),
        color: Colors.blue
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              for (String value in _tags)
                getTag(value)
            ],
          ),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: 'use \',\' to separate tags'
            ),
            onChanged: onTagFieldChanged,
          ),
        ]
      )
    );
  }
}