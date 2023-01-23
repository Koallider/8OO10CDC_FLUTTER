import 'dart:math';

import 'package:countdown_solver/base_widgets/letter.dart';
import 'package:countdown_solver/solver/letter_solver/letter_solver.dart';
import 'package:countdown_solver/solver/letter_solver/trie.dart';
import 'package:countdown_solver/solver/letter_solver/trie_builder.dart';
import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LettersGameWidget extends StatefulWidget {
  const LettersGameWidget({Key? key}) : super(key: key);

  @override
  State<LettersGameWidget> createState() => _LettersGameWidgetState();
}

class _LettersGameWidgetState extends State<LettersGameWidget> {
  int numberOfLetters = 9;
  List<String> topResults = [];
  Trie trie = Trie();

  @override
  void initState() {
    super.initState();
    initTrie();
  }

  void initTrie() async {
    await fillTrie(trie, "assets/words.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff4f657d),
      child: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Text(
                    "Enter your letters:",
                    style: AppTheme.textStyle,
                  ),
                ),
                buildBoard(buildInputField()),
                if (topResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 4, top: 4),
                    child: Text(
                      "Results:",
                      style: AppTheme.textStyle,
                    ),
                  ),
                if (topResults.isNotEmpty)
                  buildBoard(buildResultList())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBoard(Widget child) {

    double width = MediaQuery.of(context).size.width;
    double letterSize =
    min((width - numberOfLetters * 4) / numberOfLetters, 80);

    return Container(
      width: letterSize * numberOfLetters + 2 + 34,
      decoration: BoxDecoration(
          color: AppTheme.boardOutColor,
          border: Border.all(color: AppTheme.boardOutBorderColor)),
      padding: const EdgeInsets.all(1),
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.boardMidColor,
            border: Border.all(color: AppTheme.boardMidBorderColor)),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                color: AppTheme.boardInColor,
                border: Border.all(color: AppTheme.boardInBorderColor)),
            child: child),
      ),
    );
  }

  Widget buildInputField() {
    double width = MediaQuery.of(context).size.width;
    double letterSize =
    min((width - numberOfLetters * 4) / numberOfLetters, 80);

    var style = GoogleFonts.robotoCondensed(
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
        fontSize: letterSize - 4);

    return PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.center,
      length: 9,
      animationType: AnimationType.none,
      autoFocus: true,
      errorTextSpace: 2,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          inactiveColor: AppTheme.letterBorderColor,
          activeColor: AppTheme.letterBorderColor,
          selectedColor: AppTheme.letterBorderColor,
          inactiveFillColor: AppTheme.letterBackgroundColor,
          selectedFillColor: AppTheme.letterBackgroundColor,
          activeFillColor: AppTheme.letterBackgroundColor,
          fieldHeight: letterSize,
          fieldWidth: letterSize,
          fieldOuterPadding: const EdgeInsets.all(1)),
      enableActiveFill: true,
      autoDismissKeyboard: false,
      enablePinAutofill: false,
      textStyle: style,
      onChanged: runSearch,
      appContext: context,
    );
  }

  Widget buildResultList() {
    double width = MediaQuery.of(context).size.width;
    double letterSize =
    min((width - numberOfLetters * 4) / numberOfLetters, 80);

    var style = GoogleFonts.robotoCondensed(
        fontWeight: FontWeight.bold,
        color: AppTheme.textColor,
        fontSize: letterSize - 4);

    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: topResults.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var resultWord = topResults[index].toUpperCase();

          return SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  numberOfLetters,
                      (letterIndex) => Container(
                    width: letterSize,
                    height: letterSize,
                    child: LetterWidget(
                      letter: letterIndex < resultWord.length
                          ? resultWord[letterIndex]
                          : "",
                      textStyle: style,
                    ),
                    margin: const EdgeInsets.all(1),
                  )),
            ),
          );
        }).build(context);
  }

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
