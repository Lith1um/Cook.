// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/shared/tags.dart';

class InputTags extends StatefulWidget {
  final String label;
  final Function onValueChanged;

  InputTags({Key key, @required this.label, @required this.onValueChanged}) : super(key: key);

  @override
  InputTagsState createState() => InputTagsState();
}

class InputTagsState extends State<InputTags> {
  final _controller = TextEditingController();
  String _tagsText;

  void reset() {
    _controller.text = '';
    onTagFieldChanged(null);
  }

  void onTagFieldChanged(String value) {
    setState(() => _tagsText = value);
    widget.onValueChanged(value);
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
          Tags(tagsText: _tagsText),
          TextFormField(
            controller: _controller,
            maxLines: null,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'use \',\' to separate tags'
            ),
            onChanged: onTagFieldChanged,
          ),
        ]
      )
    );
  }
}
