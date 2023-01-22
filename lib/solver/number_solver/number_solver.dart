import 'dart:collection';

class ResultNode {
  String solution;
  int result;

  ResultNode(this.solution, this.result);

  @override
  bool operator ==(Object other) {
    if(other is ResultNode) {
      return solution == (other).solution;
    }
    return false;
  }

  @override
  int get hashCode => solution.hashCode;

}

class NumberSolver {
  final isIntRegex = RegExp(r'^[+-]*\d*$');

  int target;
  List<int> nums;

  //make that work properly
  bool findAllSolutions;

  Map<String, Map<int, Set<ResultNode>>> cache = {};
  bool solutionFound = false;

  NumberSolver(
      {required this.target,
      required this.nums,
      this.findAllSolutions = false});

  Set<ResultNode> solve() {
    var result = solveRecursive(nums);
    return result[target] ?? <ResultNode>{};
  }

  Map<int, Set<ResultNode>> solveRecursive(List<int> nums) {
    var result = HashMap<int, Set<ResultNode>>();
    if (!findAllSolutions && solutionFound) return result;
    if (nums.length == 1) {
      var x = nums[0];
      addResult(result, x, ResultNode("$x", x));
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
          if (r1 >= r2) {
            var calcResult = r1 + r2;
            addResults(
                result, calcResult, comb(s1[r1]!, "+", s2[r2]!, calcResult));
            if (r1 > 1 && r2 > 1) {
              var calcResult = r1 * r2;
              addResults(
                  result, calcResult, comb(s1[r1]!, "*", s2[r2]!, calcResult));
            }
          }
          var calcResult = r1 - r2;
          if (calcResult > 0) {
            addResults(
                result, calcResult, comb(s1[r1]!, "-", s2[r2]!, calcResult));
          }
          calcResult = r2 - r1;
          if (calcResult > 0) {
            addResults(
                result, calcResult, comb(s2[r2]!, "-", s1[r1]!, calcResult));
          }
          if (r1 > 1 && r2 % r1 == 0) {
            calcResult = r2 ~/ r1;
            addResults(
                result, calcResult, comb(s2[r2]!, "/", s1[r1]!, calcResult));
          }
          if (r2 > 1 && r1 % r2 == 0) {
            calcResult = r1 ~/ r2;
            addResults(
                result, calcResult, comb(s1[r1]!, "/", s2[r2]!, calcResult));
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
    var temp = subset.toList();
    return complete.where((element) => !temp.remove(element)).toList();
  }

  void addResult(Map<int, Set<ResultNode>> map, int key, ResultNode solution) {
    var set = map.putIfAbsent(key, () => {});
    set.add(solution);
  }

  void addResults(
      Map<int, Set<ResultNode>> map, int key, Set<ResultNode> solutions) {
    var set = map.putIfAbsent(key, () => {});
    set.addAll(solutions);
  }

  Set<ResultNode> comb(
      Set<ResultNode> s1, String op, Set<ResultNode> s2, int calcResult) {
    Set<ResultNode> result = HashSet();
    for (ResultNode a in s1) {
      for (ResultNode b in s2) {
        result.add(operationToString(a, op, b, calcResult));
      }
    }
    return result;
  }

  bool isSingleInt(String x) {
    return isIntRegex.hasMatch(x);
  }

  ResultNode operationToString(
      ResultNode a, String op, ResultNode b, int calcResult) {
    if (isSingleInt(a.solution) && isSingleInt(b.solution)) {
      return ResultNode(
          "${a.solution} $op ${b.solution} = $calcResult\n", calcResult);
    }
    if (isSingleInt(a.solution)) {
      return ResultNode(
          "${b.solution}${a.solution} $op ${b.result} = $calcResult\n",
          calcResult);
    }
    if (isSingleInt(b.solution)) {
      return ResultNode(
          "${a.solution}${a.result} $op ${b.solution} = $calcResult\n",
          calcResult);
    }
    return ResultNode(
        "${a.solution}${b.solution}${a.result} $op ${b.result} = $calcResult\n",
        calcResult);
  }
}
