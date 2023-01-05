import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';

class DropdownNumber extends StatefulWidget {
  final TextStyle? textStyle;

  const DropdownNumber({Key? key, this.textStyle}) : super(key: key);

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
        child: DropdownButton<int>(
          value: value,
          alignment: Alignment.center,
          dropdownColor: AppTheme.letterBackgroundColor,
          underline: Container(),
          hint: Container(),
          items: possibleNumbers
              .map((item) => DropdownMenuItem(
                    child: Text(
                      "$item",
                      style: widget.textStyle ?? AppTheme.letterTextStyle,
                    ),
                    value: item,
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
          },
        ));
  }
}
