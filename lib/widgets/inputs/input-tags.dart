// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/widgets/tags.dart';

class InputTags extends StatefulWidget {
  final String label;
  final Function onValueChanged;

  InputTags({@required this.label, @required this.onValueChanged});

  @override
  _InputTagsState createState() => _InputTagsState();
}

class _InputTagsState extends State<InputTags> {
  final _controller = TextEditingController();
  String _tagsText = '';

  void onTagFieldChanged(String value) {
    _tagsText = value;
    widget.onValueChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tags(tagsText: _tagsText),
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
