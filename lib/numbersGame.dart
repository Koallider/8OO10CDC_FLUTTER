import 'package:countdown_solver/base_widgets/target_number.dart';
import 'package:countdown_solver/solver/number_solver/number_solver.dart';
import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';

import 'base_widgets/dropdown_number.dart';

class NumbersGameWidget extends StatefulWidget {
  const NumbersGameWidget({Key? key}) : super(key: key);

  @override
  State<NumbersGameWidget> createState() => _NumbersGameWidgetState();
}

class _NumbersGameWidgetState extends State<NumbersGameWidget> {
  int? target;
  List<int?> numbers = List.generate(6, (index) => null);

  Set<String> solutions = {};

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
                TargetNumberWidget(
                  onChanged: (value) {
                    target = int.parse(value);
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    "Select Numbers:",
                    style: AppTheme.textStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      6,
                      (index) => Container(
                          padding: const EdgeInsets.all(2),
                          child: DropdownNumber(
                            onChanged: (value) {
                              numbers[index] = value;
                            },
                          ))),
                ),
                TextButton(
                    onPressed: () {
                      //todo validate input
                      var solver = NumberSolver(
                          target: target!,
                          nums: numbers.map((e) => e!).toList(),
                          findAllSolutions: false);
                      setState(() {
                        solutions = solver.solve();
                      });
                    },
                    child: Text("SOLVE")),
                //todo loading and no solutions text
                solutions.isNotEmpty ? Column(children: [Text(solutions.toList().first)]) : Text("No solution")
              ],
            ),
          ),
        ));
  }
}
