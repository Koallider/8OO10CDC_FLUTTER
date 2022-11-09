import 'package:countdown_solver/base_widgets/letter.dart';
import 'package:countdown_solver/solver/letter_solver.dart';
import 'package:countdown_solver/solver/trie.dart';
import 'package:countdown_solver/solver/trie_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Solver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SolverPage(),
    );
  }
}

class SolverPage extends StatefulWidget {
  const SolverPage({Key? key}) : super(key: key);

  @override
  State<SolverPage> createState() => _SolverPageState();
}

class _SolverPageState extends State<SolverPage> {
  List<String> word = List.generate(9, (index) => "");

  String resultString = "";

  Trie trie = Trie();

  void initState() {
    super.initState();
    initTrie();
  }

  void initTrie() async {
    await fillTrie(trie, "words.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  9,
                  (index) => Container(
                        width: 100,
                        height: 100,
                        child: LetterWidget(
                          letter: word[index],
                          editable: true,
                          onChanged: (String value) {
                            setState(() {
                              word[index] = value.toLowerCase();
                            });
                            var wordToSearch = word.join();
                            if (wordToSearch.length > 1) {
                              var result = searchForAllPermutations(
                                  trie, wordToSearch.toLowerCase().split(""));
                              result
                                  .sort((a, b) => b.length.compareTo(a.length));
                              setState(() {
                                if (result.isEmpty) {
                                  resultString = "";
                                } else {
                                  resultString = result.first.toUpperCase();
                                }
                              });
                            }else{
                              setState(() {
                                resultString = "";
                              });
                            }
                          },
                        ),
                        margin: const EdgeInsets.all(4),
                      )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  9,
                  (index) => Container(
                        width: 100,
                        height: 100,
                        child: LetterWidget(
                            letter: index < resultString.length
                                ? resultString[index]
                                : ""),
                        margin: const EdgeInsets.all(4),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
