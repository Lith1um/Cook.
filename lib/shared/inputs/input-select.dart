// Libs
import 'package:flutter/material.dart';

class SelectOption {
  final String label;
  final String value;

  SelectOption(this.label, this.value);
}

class InputSelect extends StatefulWidget {
  final String label;
  final List<SelectOption> options;
  final Function onValueChanged;

  const InputSelect({
    Key key,
    @required this.label,
    @required this.options,
    @required this.onValueChanged
  }) : super(key: key);

  @override
  InputSelectState createState() => InputSelectState();
}

class InputSelectState extends State<InputSelect> {

  final _controller = TextEditingController();
  List<DropdownMenuItem<SelectOption>> _dropdownMenuItems;
  SelectOption _selectedOption;

  void reset() {
    _controller.text = '';
    onDropdownItemChanged(_dropdownMenuItems[0].value);
  }

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(widget.options);
    _selectedOption = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<SelectOption>> buildDropdownMenuItems(List options) {
    List<DropdownMenuItem<SelectOption>> items = List();
    
    // Add an empty value
    items.add(
      DropdownMenuItem(
        value: SelectOption('', null),
        child: Text('')
      )
    );

    for (SelectOption option in options) {
      items.add(
        DropdownMenuItem(
          value: option,
          child: Text(option.label)
        )
      );
    }
    return items;
  }

  void onDropdownItemChanged(SelectOption option) {
    setState(() => _selectedOption = option);
    widget.onValueChanged(_selectedOption.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
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
          DropdownButton(
            isExpanded: true,
            value: _selectedOption,
            items: _dropdownMenuItems,
            onChanged: onDropdownItemChanged
          )
        ]
      )
    );
  }
}