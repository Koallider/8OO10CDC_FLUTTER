import 'dart:convert';

import 'package:countdown_solver/solver/letter_solver/trie.dart';
import 'package:countdown_solver/solver/letter_solver/trie_builder.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) {
      final Uint8List encoded = utf8.encoder.convert('test\nword');
      return Future.value(encoded.buffer.asByteData());
    });
  });
  test("Test that trie was build correct from assets", () async {
    Trie trie = Trie();
    TrieSearchResult result = trie.searchAll("test");
    expect(result.longestMatch, equals(0));
    await fillTrie(trie, "mock");
    result = trie.searchAll("test");
    expect(result.words, contains("test"));
    expect(result.longestMatch, equals(4));

    result = trie.searchAll("word");
    expect(result.words, contains("word"));
    expect(result.longestMatch, equals(4));

    result = trie.searchAll("dogs");
    expect(result.longestMatch, equals(0));
  });
}
