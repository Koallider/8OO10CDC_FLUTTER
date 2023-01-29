import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';

class DropdownNumber extends StatefulWidget {
  final TextStyle? textStyle;
  final ValueChanged<int?>? onChanged;

  const DropdownNumber({Key? key, this.textStyle, this.onChanged}) : super(key: key);

  @override
  State<DropdownNumber> createState() => _DropdownNumberState();
}

class _DropdownNumberState extends State<DropdownNumber> {
  var possibleNumbers = [100, 75, 50, 25, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1];

  int? value;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 115,
        height: 70,
        decoration: BoxDecoration(
            color: AppTheme.letterBackgroundColor,
            border: Border.all(color: AppTheme.letterBorderColor, width: 2)),
        alignment: Alignment.center,
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<int>(
            value: value,
            alignment: Alignment.center,
            dropdownColor: AppTheme.letterBackgroundColor,
            validator: (value) {
              if (value == null) {
                return "";//Input is empty
              }
              return null;
            },
            style: widget.textStyle ?? AppTheme.letterTextStyle,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0.01),
            ),
            //underline: Container(),
            hint: Container(),
            items: possibleNumbers
                .map((item) => DropdownMenuItem(
                      child: Text(
                        "$item",
                        textAlign: TextAlign.center,
                      ),
                      value: item,
                    ))
                .toList(),
            onChanged: (newValue) {
              setState(() {
                value = newValue;
                widget.onChanged?.call(newValue);
              });
            },
          ),
        ));
  }
}
