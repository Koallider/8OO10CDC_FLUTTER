import 'package:countdown_solver/solver/number_solver/number_solver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Number solver tests", () {
    test("No solution test", (){
      var solver = NumberSolver(target: 333, nums: [1, 2]);
      var result = solver.solve();
      expect(result.length, equals(0));
    });
    test("2 numbers test", (){
      var solver = NumberSolver(target: 6, nums: [2, 3]);
      var result = solver.solve();
      expect(result.length, equals(1));
      expect(result, containsAll(["3*2"]));
    });
    test("3 numbers test", (){
      var solver = NumberSolver(target: 16, nums: [2, 4, 6]);
      var result = solver.solve();
      expect(result.length, equals(2));
      expect(result, containsAll(["(6*2)+4", "(6-2)*4"]));
    });
    test("Duplicate number test", (){
      var solver = NumberSolver(target: 4, nums: [2, 2]);
      var result = solver.solve();
      expect(result.length, equals(2));
      expect(result, containsAll(["2*2", "2+2"]));
    });
  });
}
