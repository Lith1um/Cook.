import 'package:cook/widgets/inputs/input-number.dart';
import 'package:flutter/material.dart';

class TimeOption {
  final String type;
  final int multiplier;

  TimeOption(this.type, this.multiplier);

  static List<TimeOption> getTimeOptions() {
    return <TimeOption>[
      TimeOption('Mins', 1),
      TimeOption('Hours', 60),
    ];
  }
}

class InputTime extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isRequired;
  final String requiredMessage;

  const InputTime({
    @required this.controller,
    @required this.label,
    this.isRequired = false,
    this.requiredMessage = 'This field is required'
  });

  @override
  _InputTimeState createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> {
  List<TimeOption> _options = TimeOption.getTimeOptions();
  List<DropdownMenuItem<TimeOption>> _dropdownMenuItems;
  TimeOption _selectedOption;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_options);
    _selectedOption = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<TimeOption>> buildDropdownMenuItems(List options) {
    List<DropdownMenuItem<TimeOption>> items = List();

    for (TimeOption option in options) {
      items.add(
        DropdownMenuItem(
          value: option,
          child: Text(option.type)
        )
      );
    }
    return items;
  }

  void onChangeDropdownItem(TimeOption option) {
    setState(() {
      _selectedOption = option;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InputNumber(
            inputController: widget.controller,
            label: widget.label,
          ),
        ),
        DropdownButton(
          value: _selectedOption,
          items: _dropdownMenuItems,
          onChanged: onChangeDropdownItem
        )
      ],
    );
  }
}