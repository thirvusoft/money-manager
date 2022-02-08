import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:money_manager/views/screens/landingScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String display = "";
Color color = Colors.blueAccent;

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.linear,
        items: [
          Icon(Icons.home),
          Icon(Icons.face),
          Icon(Icons.settings),
        ],
        onTap: (index) {
          setState(() {
            {
              home_page;
            }
          });
        },
      ),
      body: Container(
        color: Colors.deepOrange,
        child: Center(
          child: home_page(),
        ),
      ),
    );
  }
}
