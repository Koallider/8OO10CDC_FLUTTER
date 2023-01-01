import 'package:countdown_solver/solver/letter_solver/trie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Trie tests", () {
    late Trie trie;
    setUp((){
      trie = Trie();
      trie.insertWord("test");
      trie.insertWord("tester");
    });
    test("Search for shortest entry", (){
      TrieSearchResult result = trie.searchAll("test");
      expect(result.longestMatch, equals(4));
      expect(result.words, contains("test"));
      expect(result.words.length, equals(1));
    });
    test("Search for longest entry", (){
      TrieSearchResult result = trie.searchAll("tester");
      expect(result.longestMatch, equals(6));
      expect(result.words, allOf(contains("test"), contains("tester")));
      expect(result.words.length, equals(2));
    });
    test("Search for non existing string with existing substring", (){
      TrieSearchResult result = trie.searchAll("tested");
      expect(result.longestMatch, equals(5));
      expect(result.words, allOf(contains("test")));
      expect(result.words.length, equals(1));
    });
    test("Search for non existing string", (){
      TrieSearchResult result = trie.searchAll("word");
      expect(result.longestMatch, equals(0));
      expect(result.words.length, equals(0));
    });
    test("Search for the beginning of the existing string", (){
      TrieSearchResult result = trie.searchAll("tes");
      expect(result.longestMatch, equals(3));
      expect(result.words.length, equals(0));
    });
  });
}