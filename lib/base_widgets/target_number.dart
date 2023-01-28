import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';

class TargetNumberWidget extends StatefulWidget {
  final TextStyle? textStyle;
  final ValueChanged<String>? onChanged;

  const TargetNumberWidget({Key? key, this.textStyle, this.onChanged}) : super(key: key);

  @override
  State<TargetNumberWidget> createState() => _TargetNumberWidgetState();
}

class _TargetNumberWidgetState extends State<TargetNumberWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        decoration: BoxDecoration(
            color: AppTheme.letterBackgroundColor,
            border: Border.all(color: AppTheme.letterBorderColor, width: 2)),
        alignment: Alignment.center,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "";//Input is empty
            }
            if(int.tryParse(value) == null){
              return "";//Not an integer
            }
            return null;
          },
          decoration: const InputDecoration(
            errorStyle: TextStyle(height: 0.01),
            counterText: "",
          ),
          onChanged: widget.onChanged,
          maxLines: 1,
          maxLength: 3,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: widget.textStyle ?? AppTheme.letterTextStyle,
        ));
  }
}
