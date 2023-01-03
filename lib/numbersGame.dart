import 'package:countdown_solver/base_widgets/target_number.dart';
import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';

class NumbersGameWidget extends StatefulWidget {
  const NumbersGameWidget({Key? key}) : super(key: key);

  @override
  State<NumbersGameWidget> createState() => _NumbersGameWidgetState();
}

class _NumbersGameWidgetState extends State<NumbersGameWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff4f657d),
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    "Enter your target number:",
                    style: AppTheme.textStyle,
                  ),
                ),
                const TargetNumberWidget(),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    "Select Numbers:",
                    style: AppTheme.textStyle,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
