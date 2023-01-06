import 'dart:collection';

enum Operator { add, sub, div, mul }

typedef Operation = Function(num a, num b);

var operatorMap = {
  Operator.add: (a, b) => a + b,
  Operator.sub: (a, b) => a - b,
  Operator.div: (a, b) => a / b,
  Operator.mul: (a, b) => a * b,
};

class RPNWrapper {
  num? number;
  Operator? operator;

  RPNWrapper({this.number, this.operator});
}

class NumberSolver {

  num calculateRPN(List<RPNWrapper> rpn) {
    Queue stack = Queue<num>();

    for (var element in rpn) {
      if (element.number != null) {
        stack.add(element.number);
      } else if (element.operator != null) {
        var b = stack.removeLast();
        var a = stack.removeFirst();
        stack.add(operatorMap[element.operator]!.call(a, b));
      }
    }
    return stack.first;
  }
}