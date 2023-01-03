import 'dart:collection';
import 'dart:core';
import 'dart:math';

import 'package:countdown_solver/solver/letter_solver/trie.dart';

List<String> searchForAllPermutations(Trie trie, List<String> word) {
  Set<String> results = HashSet<String>();

  int size = word.length;
  word.sort();

  bool isFinished = false;

  while (!isFinished) {
    var searchResult = trie.searchAll(word.join());
    results.addAll(searchResult.words);

    var i = min(searchResult.longestMatch, size - 2);
    //by doing this we throw away all permutations from index i
    //which are not in the dictionary
    var begin = word.sublist(0, i + 1);
    var end = word.sublist(i + 1, size);
    end.sort((a, b) => b.compareTo(a));
    word = begin + end;

    while (i >= 0) {
      if (word[i].compareTo(word[i + 1]) < 0){
        break;
      }
      i--;
    }

    if (i == -1) {
      isFinished = true;
    } else {
      var ceilIndex = findCeil(word, i);
      swap(word, i, ceilIndex);
      reverse(word, i + 1, size - 1);
    }
  }
  return results.toList();
}

void swap(List<String> word, int a, int b) {
  var tmp = word[a];
  word[a] = word[b];
  word[b] = tmp;
}

void reverse(List<String> word, int fromIndex, int toIndex) {
  while (fromIndex < toIndex) {
    swap(word, fromIndex, toIndex);
    fromIndex++;
    toIndex--;
  }
}

/// Returns the smallest character which is greater than
/// the character on the [fromIndex] position
int findCeil(List<String> word, int fromIndex) {
  var ceilIndex = fromIndex + 1;

  for (var i = fromIndex + 1; i < word.length; i++) {
    if (word[i].compareTo(word[fromIndex]) > 0 &&
        word[i].compareTo(word[ceilIndex]) < 0) {
      ceilIndex = i;
    }
  }
  return ceilIndex;
}
