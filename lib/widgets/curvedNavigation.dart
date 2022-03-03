import 'package:flutter/material.dart';
import '../views/categories/assets.dart';
import '../views/categories/liability.dart';
import '../views/screens/search.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    searchbar(),
    searchbar(),
    searchbar(),
    searchbar(),
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
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
