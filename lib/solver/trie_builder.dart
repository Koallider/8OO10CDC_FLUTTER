import 'package:countdown_solver/solver/trie.dart';
import 'package:flutter/services.dart';

Future<Trie> fillTrie(Trie trie, String dictionaryAssetPath) async {
  String dictionary = await rootBundle.loadString(dictionaryAssetPath);
  dictionary.split("\n").forEach((element) {
    trie.insertWord(element);
  });
  return trie;
}