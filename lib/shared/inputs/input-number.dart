// Libs
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumber extends StatelessWidget {
  final TextEditingController inputController;
  final String label;
  final bool isRequired;
  final String requiredMessage;

  const InputNumber({
    @required this.inputController,
    @required this.label,
    this.isRequired = false,
    this.requiredMessage = 'This field is required'
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        labelText: label
      ),
      validator: (value) {
        if (isRequired && value.isEmpty) {
          return requiredMessage;
        }
        return null;
      },
    );
  }
}
