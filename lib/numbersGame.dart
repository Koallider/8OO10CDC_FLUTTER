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

class _NumbersGameWidgetState extends State<NumbersGameWidget>
    with AutomaticKeepAliveClientMixin<NumbersGameWidget> {
  final _formKey = GlobalKey<FormState>();

  int? target;
  List<int?> numbers = List.generate(6, (index) => null);

  Set<ResultNode>? solutions;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: _formKey,
      child: Container(
          color: const Color(0xff4f657d),
          child: SafeArea(
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
                  Wrap(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Container(
                                padding: const EdgeInsets.all(2),
                                child: DropdownNumber(
                                  onChanged: (value) {
                                    numbers[index] = value;
                                  },
                                ))),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            3,
                            (index) => Container(
                                padding: const EdgeInsets.all(2),
                                child: DropdownNumber(
                                  onChanged: (value) {
                                    numbers[3 + index] = value;
                                  },
                                ))),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: MaterialButton(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 32, right: 32),
                        color: AppTheme.letterBackgroundColor,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var solver = NumberSolver(
                                target: target!,
                                nums: numbers.map((e) => e!).toList(),
                                findAllSolutions: false);
                            setState(() {
                              solutions = solver.solve();
                            });
                          }
                        },
                        child: const Text(
                          "SOLVE",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.topCenter,
                    constraints: const BoxConstraints.expand(),
                    color: AppTheme.boardInBorderColor,
                    child: solutions == null
                        ? Container()
                        : solutions!.isNotEmpty
                            ? Column(children: [
                                Text(solutions!.toList().first.solution,
                                    style: AppTheme.textStyle)
                              ])
                            : Text("No solution", style: AppTheme.textStyle),
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
