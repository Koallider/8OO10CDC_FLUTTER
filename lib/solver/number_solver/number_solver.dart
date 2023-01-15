import 'dart:collection';

class NumberSolver {
  final isIntRegex = RegExp(r'^[+-]*\d*$');

  int target;
  List<int> nums;
  bool findAllSolutions;

  Map<String, Map<int, Set<String>>> cache = {};
  bool solutionFound = false;

  NumberSolver(
      {required this.target,
      required this.nums,
      this.findAllSolutions = false});

  Set<String>? solve() {
    var result = solveRecursive(nums);
    return result[target];
  }

  Map<int, Set<String>> solveRecursive(List<int> nums) {
    var result = HashMap<int, Set<String>>();
    if (!findAllSolutions && solutionFound) return result;
    if (nums.length == 1) {
      var x = nums[0];
      addResult(result, x, "$x");
      return result;
    }
    nums.sort();
    var numsToString = nums.join(",");
    if (cache.containsKey(numsToString)) return cache[numsToString]!;
    for (var subset in subsets(nums)) {
      var comp = subtractList(nums, subset);
      if (subset.isEmpty || comp.isEmpty || subset.length < comp.length) {
        continue;
      }
      var s1 = solveRecursive(subset);
      var s2 = solveRecursive(comp);
      for (var r1 in s1.keys) {
        addResults(result, r1, s1[r1]!);
        for (var r2 in s2.keys) {
          addResults(result, r2, s2[r2]!);
          if (r1 > r2) {
            addResults(result, r1 + r2, comb(s1[r1]!, "+", s2[r2]!));
            addResults(result, r1 * r2, comb(s1[r1]!, "*", s2[r2]!));
          }

          addResults(result, r1 - r2, comb(s1[r1]!, "-", s2[r2]!));
          addResults(result, r2 - r1, comb(s2[r2]!, "-", s1[r1]!));
          if (r1 != 0 && r2 % r1 == 0) {
            addResults(result, r2 ~/ r1, comb(s2[r2]!, "/", s1[r1]!));
          }
          if (r2 != 0 && r1 % r2 == 0) {
            addResults(result, r1 ~/ r2, comb(s1[r1]!, "/", s2[r2]!));
          }
        }
      }
    }
    cache[numsToString] = result;
    if (result.containsKey(target)) {
      solutionFound = true;
    }
    return result;
  }

  List<List<int>> subsets(List<int> nums) {
    List<List<int>> result = [];
    result.add([nums[0]]);
    if (nums.length == 1) {
      return result;
    }
    var x = nums.removeAt(0);
    for (var part in subsets(nums)) {
      result.add(part.toList());
      result.add([x, ...part]);
    }
    nums.insert(0, x);
    return result;
  }

  List<int> subtractList(List<int> complete, List<int> subset) {
    return complete.where((element) => !subset.contains(element)).toList();
  }

  void addResult(Map<int, Set<String>> map, int key, String solution) {
    var set = map.putIfAbsent(key, () => {});
    set.add(solution);
  }

  void addResults(Map<int, Set<String>> map, int key, Set<String> solutions) {
    var set = map.putIfAbsent(key, () => {});
    set.addAll(solutions);
  }

  Set<String> comb(Set<String> s1, String op, Set<String> s2) {
    Set<String> result = HashSet();
    for (String a in s1) {
      for (String b in s2) {
        result.add(operationToString(a, op, b));
      }
    }
    return result;
  }

  bool isSingleInt(String x) {
    return isIntRegex.hasMatch(x);
  }

  String operationToString(String a, String op, String b) {
    if (isSingleInt(a) && isSingleInt(b)) return a + op + b;
    if (isSingleInt(a)) return "$a$op($b)";
    if (isSingleInt(b)) {
      return "($a)$op$b";
    } else {
      return "($a)$op($b)";
    }
  }
}
