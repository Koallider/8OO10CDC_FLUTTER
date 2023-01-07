import 'package:countdown_solver/solver/number_solver/number_solver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("RPN calculator test", () {
    NumberSolver solver = NumberSolver();
    var rpn = [
      RPNWrapper(number: 3),
      RPNWrapper(number: 4),
      RPNWrapper(operator: Operator.sub),
      RPNWrapper(number: 5),
      RPNWrapper(operator: Operator.add),
      RPNWrapper(number: 4),
      RPNWrapper(operator: Operator.mul),
      RPNWrapper(number: 2),
      RPNWrapper(operator: Operator.div),
    ];
    expect(solver.calculateRPN(rpn), 8);
  });
  test("RPN calculator test 2", () {
    NumberSolver solver = NumberSolver();
    var rpn = [
      RPNWrapper(number: 3),
      RPNWrapper(number: 1),
      RPNWrapper(operator: Operator.sub),
      RPNWrapper(number: 4),
      RPNWrapper(number: 2),
      RPNWrapper(operator: Operator.sub),
      RPNWrapper(operator: Operator.mul),
    ];
    expect(solver.calculateRPN(rpn), 4);
  });
}
