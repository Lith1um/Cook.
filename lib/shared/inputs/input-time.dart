// Libs
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final String label;
  final Function onValueChanged;
  final bool isRequired;
  final String requiredMessage;

  const InputTime({
    @required this.label,
    @required this.onValueChanged,
    this.isRequired = false,
    this.requiredMessage = 'This field is required',
  });

  @override
  _InputTimeState createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> {
  final _controller = TextEditingController();
  List<TimeOption> _options = TimeOption.getTimeOptions();
  List<DropdownMenuItem<TimeOption>> _dropdownMenuItems;
  TimeOption _selectedOption;
  int _timeInMinutes = 0;

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

  void onDropdownItemChanged(TimeOption option) {
    setState(() {
      _selectedOption = option;
    });
    onValueChanged(_controller.text);
  }

  void onValueChanged(String value) {
    setState(() {
      _timeInMinutes = value != '' ?
        int.parse(value) * _selectedOption.multiplier : null;
    });
    widget.onValueChanged(_timeInMinutes);
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                labelText: widget.label
              ),
              validator: (value) {
                if (widget.isRequired && value.isEmpty) {
                  return widget.requiredMessage;
                }
                return null;
              },
              onChanged: onValueChanged,
            )
          ),
          DropdownButton(
            value: _selectedOption,
            items: _dropdownMenuItems,
            onChanged: onDropdownItemChanged
          )
        ],
      ),
    );
  }
}