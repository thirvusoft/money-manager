import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:money_manager/views/screens/landingScreen.dart';

import '../views/screens/settingsScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Color color = Colors.blueAccent;

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;

  final tabs = [
    home_page(),
    settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.linear,
        items: [
          Icon(Icons.home),
          Icon(Icons.settings),
        ],
        onTap: (index) {
          setState(
            () {
              {
                activeIndex = index;
              }
            },
          );
        },
      ),
      body: tabs[activeIndex],
    );
  }
}
