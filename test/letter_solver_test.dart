import 'package:countdown_solver/solver/letter_solver/letter_solver.dart';
import 'package:countdown_solver/solver/letter_solver/trie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Solver util methods", () {
    test("Test swap 2 elements in list", () {
      var list = ["a", "b", "c"].toList();
      swap(list, 0, 2);
      expect(list, equals(["c", "b", "a"].toList()));
    });
    test("Test list reverse", (){
      var list = ["a", "b", "c", "d"].toList();
      reverse(list, 1, 3);
      expect(list, equals(["a", "d", "c", "b"].toList()));

      list = ["a", "b", "c", "d"].toList();
      reverse(list, 0, 3);
      expect(list, equals(["d", "c", "b", "a"].toList()));
    });
    test("Test Finding ceil in list", (){
      var list = ["d", "a", "c", "b"].toList();
      expect(findCeil(list, 1), equals(3));
    });
  });
  group("Letters game solver", () {
    late Trie trie;
    setUp((){
      trie = Trie();
      trie.insertWord("dog");
      trie.insertWord("dogs");
      trie.insertWord("gods");
      trie.insertWord("bogs");
      trie.insertWord("cat");
      trie.insertWord("cats");
    });
    test("Search for all permutations", (){
      var result = searchForAllPermutations(trie, "sdgob".split(""));
      expect(result, containsAll(["dog", "dogs", "bogs", "gods"]));
      expect(result, isNot(contains("cat")));
      expect(result.length, equals(4));
    });
  });
}
