class TrieSearchResult {
  List<String> words;
  int longestMatch;

  TrieSearchResult(this.words, this.longestMatch);
}

class TrieNode {
  Map<String, TrieNode> children = {};
  bool isWord = false;
}

class Trie {
  final TrieNode _root = TrieNode();

  void insertWord(String word) {
    var currentNode = _root;
    word.toLowerCase().runes.forEach((charCode) {
      String key = String.fromCharCode(charCode);
      if (!currentNode.children.containsKey(key)) {
        currentNode.children[key] = TrieNode();
      }
      currentNode = currentNode.children[key]!;
    });
    currentNode.isWord = true;
  }

  TrieSearchResult searchAll(String word) {
    var currentNode = _root;
    var matchLength = 0;

    List<String> words = [];
    for (int i = 0; i < word.length; i++) {
      var nextNode = currentNode.children[word[i]];
      if (nextNode != null) {
        currentNode = nextNode;
        matchLength += 1;
        if (currentNode.isWord) {
          words.add(word.substring(0, i + 1));
        }
      } else {
        break;
      }
    }
    return TrieSearchResult(words, matchLength);
  }
}
