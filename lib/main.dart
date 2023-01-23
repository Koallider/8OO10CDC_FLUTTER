import 'package:countdown_solver/theme.dart';
import 'package:flutter/material.dart';

import 'lettersGame.dart';
import 'numbersGame.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Solver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppTheme.letterBackgroundColor,
              child: TabBar(
                controller: controller,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.textColor,
                tabs: const [
                  Tab(text: "Letters Game",),
                  Tab(text: "Numbers Game",),
                ],
              ),
            ),
            Expanded(child: TabBarView(
              controller: controller,
              children: const [LettersGameWidget(), NumbersGameWidget()],
            ))
          ],
        ),
      ),
    );
  }
}
