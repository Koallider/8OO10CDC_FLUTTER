import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';

class TargetNumberWidget extends StatefulWidget {
  final TextStyle? textStyle;

  const TargetNumberWidget({Key? key, this.textStyle}) : super(key: key);

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
        child: TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: widget.textStyle ?? AppTheme.letterTextStyle,
        ));
  }
}
