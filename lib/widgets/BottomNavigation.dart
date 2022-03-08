import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Homescreen/expensesSearch.dart';
import 'package:money_manager/views/screens/Homescreen/incomeSearch.dart';
import 'package:money_manager/views/screens/Homescreen/liabilitySearch.dart';
import 'package:money_manager/views/screens/Homescreen/othersSearch.dart';
import 'package:money_manager/views/screens/Homescreen/search.dart';
import 'package:money_manager/views/screens/profile.dart';
class bottomnavigation extends StatefulWidget {
  const bottomnavigation({Key? key}) : super(key: key);
  @override
  _bottomnavigationState createState() => _bottomnavigationState();
}
class _bottomnavigationState extends State<bottomnavigation> {
  int currentIndex = 0;
  List widgetOptions = [
    searchbar(),
    liabilitySearch(),
    expenseSearch(),
    incomeSearch(),
    othersSearch(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(
            () {
              currentIndex = index;
            },
          );
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon:
                Icon(Icons.home_work, color: Color.fromARGB(255, 93, 99, 217)),
            title: Text("Asrsets",
                style: TextStyle(color: Color.fromARGB(255, 93, 99, 217))),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.assessment_outlined,
                color: Color.fromARGB(255, 93, 99, 217)),
            title: Text("Liability",
                style: TextStyle(color: Color.fromARGB(255, 93, 99, 217))),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.savings, color: Color.fromARGB(255, 93, 99, 217)),
            title: Text("Expense",
                style: TextStyle(color: Color.fromARGB(255, 93, 99, 217))),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.money, color: Color.fromARGB(255, 93, 99, 217)),
            title: Text("Income",
                style: TextStyle(color: Color.fromARGB(255, 93, 99, 217))),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.plus_one_outlined,
                color: Color.fromARGB(255, 93, 99, 217)),
            title: Text("Others",
                style: TextStyle(color: Color.fromARGB(255, 93, 99, 217))),
          ),
          BottomNavyBarItem(
            icon:
                Icon(Icons.person_add, color: Color.fromARGB(255, 93, 99, 217)),
            title: Text("Profile",
                style: TextStyle(color: Color.fromARGB(255, 93, 99, 217))),
          ),
        ],
      ),
    );
  }
}