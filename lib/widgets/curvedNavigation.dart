import 'dart:html';

import 'package:flutter/material.dart';

import '../views/categories/assets.dart';
import '../views/categories/liability.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List<Widget> _widgetOptions = <Widget>[
  //   MyHomePage(),
  //   MyHomePage1(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money,
              color: Colors.blue.shade400,
            ),
            label: 'Money',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.savings,
              color: Colors.blue.shade400,
            ),
            label: 'Saving',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.savings,
              color: Colors.blue.shade400,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings, color: Colors.blue.shade400),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      // body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:money_manager/views/screens/landingScreen.dart';

// import '../views/screens/settingsScreen.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// Color color = Colors.blue.shade900;

// class _MyHomePageState extends State<MyHomePage> {
//   int activeIndex = 0;

//   final tabs = [
//     home_page(),
//     settings(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         animationCurve: Curves.linear,
//         items: [
//           Icon(Icons.home),
//           Icon(Icons.settings),
//         ],
//         onTap: (index) {
//           setState(
//             () {
//               {
//                 activeIndex = index;
//               }
//             },
//           );
//         },
//       ),
//       body: tabs[activeIndex],
//     );
//   }
// }
