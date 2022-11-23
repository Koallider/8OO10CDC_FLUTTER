import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color letterBackgroundColor = Color(0xff012988);
  static const Color letterBorderColor = Color(0xff5977bf);

  static const Color boardOutBorderColor = Color(0xff173148);
  static const Color boardOutColor = Color(0xff26466d);

  static const Color boardMidBorderColor = Color(0xff173148);
  static const Color boardMidColor = Color(0xff92c1dd);

  static const Color boardInBorderColor = Color(0xff27343a);
  static const Color boardInColor = Color(0xff4f657d);

  static const Color textColor = Colors.white;

  static TextStyle letterTextStyle = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.bold,
      color: AppTheme.textColor,
      fontSize: 50);

  static TextStyle textStyle = const TextStyle(
      fontSize: 32,
      color: textColor,
      fontWeight: FontWeight.bold);
}