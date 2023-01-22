import 'package:countdown_solver/solver/number_solver/number_solver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Number solver tests", () {
    test("No solution test", () {
      var solver = NumberSolver(target: 333, nums: [1, 2]);
      var result = solver.solve();
      expect(result.length, equals(0));
    });
    test("2 numbers test", () {
      var target = 6;
      var solver = NumberSolver(target: target, nums: [2, 3]);
      var result = solver.solve();
      expect(result.length, equals(1));
      expect(result.map((e) => e.result), everyElement(equals(target)));
      expect(result.map((e) => e.solution), contains(startsWith("3 * 2 = 6")));
    });
    test("3 numbers test", () {
      var target = 16;
      var solver = NumberSolver(target: target, nums: [2, 4, 6]);
      var result = solver.solve();
      expect(result.length, equals(2));
      expect(result.map((e) => e.result), everyElement(equals(target)));
      expect(
          result.map((e) => e.solution),
          containsAll([
            startsWith("6 - 2 = 4\n4 * 4 = 16"),
            startsWith("6 * 2 = 12\n12 + 4 = 16")
          ]));
    });
    test("Duplicate number test", () {
      var target = 4;
      var solver = NumberSolver(target: target, nums: [2, 2]);
      var result = solver.solve();
      expect(result.length, equals(2));
      expect(result.map((e) => e.result), everyElement(equals(target)));
      expect(result.map((e) => e.solution),
          containsAll([startsWith("2 + 2 = 4"), startsWith("2 * 2 = 4")]));
    });
  });
  group("Solver util methods tests", () {
    late NumberSolver utilSolver;
    setUp(() {
      utilSolver = NumberSolver(target: 1, nums: [1]);
    });
    test("Subtract list test", () {
      List<int> list1 = [1, 2, 2, 3];
      List<int> list2 = [1, 2];
      List result = utilSolver.subtractList(list1, list2);
      expect(result, equals([2, 3]));
    });
    test("Subtract list test empty list", () {
      List<int> list1 = [1, 2, 2, 3];
      List<int> list2 = [];
      List result = utilSolver.subtractList(list1, list2);
      expect(result, equals([1, 2, 2, 3]));
    });
    test("Subtract list test empty list 2", () {
      List<int> list1 = [];
      List<int> list2 = [1, 2, 2, 3];
      List result = utilSolver.subtractList(list1, list2);
      expect(result, equals([]));
    });
    test("Is single int test", () {
      expect(utilSolver.isSingleInt("10"), equals(true));
      expect(utilSolver.isSingleInt("-5"), equals(true));
      expect(utilSolver.isSingleInt("-5+1"), equals(false));
      expect(utilSolver.isSingleInt("*"), equals(false));
    });
    test("Subsets test", () {
      List<int> list = [1, 2];
      var result = utilSolver.subsets(list);
      expect(
          result,
          containsAll([
            [1],
            [2],
            [1, 2]
          ]));
    });
  });
}
