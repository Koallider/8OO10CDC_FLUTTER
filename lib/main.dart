import 'dart:math';

import 'package:countdown_solver/base_widgets/letter.dart';
import 'package:countdown_solver/solver/letter_solver/letter_solver.dart';
import 'package:countdown_solver/solver/letter_solver/trie.dart';
import 'package:countdown_solver/solver/letter_solver/trie_builder.dart';
import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
  List<String> topResults = [];
  Trie trie = Trie();

  @override
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Enter your letters:",
              style: TextStyle(fontSize: 32),
            ),
            buildInputField(),
            Expanded(child: buildResultList())
          ],
        ),
      ),
    );
  }

  Widget buildInputField() => PinCodeTextField(
        mainAxisAlignment: MainAxisAlignment.center,
        length: 9,
        animationType: AnimationType.none,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            inactiveColor: AppTheme.letterBorderColor,
            activeColor: AppTheme.letterBorderColor,
            selectedColor: AppTheme.letterBorderColor,
            inactiveFillColor: AppTheme.letterBackgroundColor,
            selectedFillColor: AppTheme.letterBackgroundColor,
            activeFillColor: AppTheme.letterBackgroundColor,
            fieldHeight: 80,
            fieldWidth: 80,
            fieldOuterPadding: const EdgeInsets.all(4)),
        enableActiveFill: true,
        autoDismissKeyboard: false,
        enablePinAutofill: false,
        textStyle: AppTheme.letterTextStyle,
        onChanged: runSearch,
        appContext: context,
      );

  Widget buildResultList() => ListView.builder(
      itemCount: topResults.length,
      itemBuilder: (BuildContext context, int index) {
        var resultWord = topResults[index].toUpperCase();

        return SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                9,
                (letterIndex) => Container(
                      width: 60,
                      height: 60,
                      child: LetterWidget(
                          letter: letterIndex < resultWord.length
                              ? resultWord[letterIndex]
                              : ""),
                      margin: const EdgeInsets.all(4),
                    )),
          ),
        );
      }).build(context);

  void runSearch(String wordToSearch) {
    if (wordToSearch.length > 1) {
      var result =
          searchForAllPermutations(trie, wordToSearch.toLowerCase().split(""));
      result.sort((a, b) => b.length.compareTo(a.length));
      setState(() {
        if (result.isEmpty) {
          topResults = [];
        } else {
          topResults = result.sublist(0, min(result.length, 10) - 1);
        }
      });
    } else {
      setState(() {
        topResults = [];
      });
    }
  }
}
