import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/DailyExpense.dart';
import 'package:myapp/NotePad.dart';
import 'PercentagePage.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
    title: "MyApp",
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  List<Widget> _children = [
    PercentagePage(),
    DailyExpensePage(),
    NotePadPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.greenAccent,
        activeIconColor: Colors.lightBlue,
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.event_note, title: "Expense"),
          TabData(iconData: Icons.note_add, title: "NotePad")
        ],
        onTabChangedListener: (position) {
          setState(() {
            _currentIndex = position;
          });
        },
      ),
      body: _children[_currentIndex],
    );
  }
}
