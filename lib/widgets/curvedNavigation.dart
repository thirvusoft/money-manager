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
    Asset(),
    Expense(),
    Income(),
    Liability(),
    ProfilePageDesign(),
    Others(),
  ];
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
              Icons.home_work,
              color: Colors.blue.shade400,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assessment_outlined,
              color: Colors.blue.shade400,
            ),
            label: 'Assest',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.savings,
              color: Colors.blue.shade400,
            ),
            label: 'Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money, color: Colors.blue.shade400),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off_csred, color: Colors.blue.shade400),
            label: 'Liability',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add, color: Colors.blue.shade400),
            label: 'Person',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one_outlined, color: Colors.blue.shade400),
            label: 'Others',
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
