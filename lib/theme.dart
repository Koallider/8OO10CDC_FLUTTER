import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static const Color letterBackgroundColor = Color(0xff012988);
  static const Color letterBorderColor = Color(0xff5977bf);
  static const Color textColor = Colors.white;

  static TextStyle letterTextStyle = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.bold,
      color: AppTheme.textColor,
      fontSize: 50);
}