import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Settings/Asset.dart';
import 'package:money_manager/views/screens/Settings/Expense.dart';
import 'package:money_manager/views/screens/Settings/Income.dart';
import 'package:money_manager/views/screens/Settings/liability.dart';
import 'package:money_manager/views/screens/Settings/Others.dart';
import 'package:money_manager/views/screens/profile.dart';
import 'package:money_manager/views/screens/search.dart';

import '../views/categories/assets.dart';
import '../views/categories/liability.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    searchbar(),
    Expense(),
    Income(),
    Liability(),
    Others(),
    ProfilePageDesign()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_work,
              color: Color.fromARGB(255, 93, 99, 216),
            ),
            label: 'Asset',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assessment_outlined,
              color: Color.fromARGB(255, 93, 99, 216),
            ),
            label: 'Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.savings,
              color: Color.fromARGB(255, 93, 99, 216),
            ),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money, color: Color.fromARGB(255, 93, 99, 216)),
            label: 'Liability',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one_outlined,
                color: Color.fromARGB(255, 93, 99, 216)),
            label: 'Others',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.person_add, color: Color.fromARGB(255, 93, 99, 216)),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
