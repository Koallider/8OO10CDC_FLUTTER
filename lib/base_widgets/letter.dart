import 'package:countdown_solver/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LetterWidget extends StatefulWidget {
  final String letter;
  final TextStyle? textStyle;

  const LetterWidget({Key? key, required this.letter, this.textStyle}) : super(key: key);

  @override
  State<LetterWidget> createState() => _LetterWidgetState();
}

class _LetterWidgetState extends State<LetterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppTheme.letterBackgroundColor,
            border: Border.all(color: AppTheme.letterBorderColor, width: 2)),
        alignment: Alignment.center,
        child: Text(
          widget.letter.length > 1
              ? widget.letter.substring(0, 1)
              : widget.letter,
          textAlign: TextAlign.center,
          style: widget.textStyle ?? AppTheme.letterTextStyle,
        ));
  }
}
