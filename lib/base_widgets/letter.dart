import 'package:countdown_solver/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LetterWidget extends StatefulWidget {
  String letter;
  final bool editable;
  final Function? onChanged;

  LetterWidget(
      {Key? key, required this.letter, this.editable = false, this.onChanged})
      : super(key: key);

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
      child: !widget.editable
          ? Text(
              widget.letter.length > 1
                  ? widget.letter.substring(0, 1)
                  : widget.letter,
              textAlign: TextAlign.center,
              style: getStyle(),
            )
          : TextField(
              onChanged: (value) {
                widget.letter = value;
                widget.onChanged?.call(value);
                if(value.isNotEmpty){
                  FocusScope.of(context).nextFocus();
                }else{
                  FocusScope.of(context).previousFocus();
                }
              },
              decoration: const InputDecoration(
                hintText: "",
                counterText: "",
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              maxLength: 1,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              style: getStyle(),
              textAlign: TextAlign.center,
            ),
    );
  }

  TextStyle getStyle() {
    return GoogleFonts.robotoCondensed(
        fontWeight: FontWeight.bold, color: AppTheme.textColor, fontSize: 50);
  }
}
