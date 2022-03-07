import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Homescreen/expensesSearch.dart';
import 'package:money_manager/views/screens/Homescreen/incomeSearch.dart';
import 'package:money_manager/views/screens/Homescreen/liabilitySearch.dart';
import 'package:money_manager/views/screens/Homescreen/othersSearch.dart';
import 'package:money_manager/views/screens/Homescreen/search.dart';
import 'package:money_manager/views/screens/profile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  int selectedpage = 0; //initial value
  final _pageOptions = [
    searchbar(),
    liabilitySearch(),
    expenseSearch(),
    incomeSearch(),
    othersSearch(),
    ProfilePage(),
  ]; // listing of all 3 pages index wise
  final bgcolor = [
    Color.fromARGB(255, 93, 99, 216),
    Color.fromARGB(255, 93, 99, 216),
    Color.fromARGB(255, 93, 99, 216),
    Color.fromARGB(255, 93, 99, 216),
    Color.fromARGB(255, 93, 99, 216),
    Color.fromARGB(255, 93, 99, 216),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[selectedpage],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        buttonBackgroundColor: Colors.white,
        backgroundColor: bgcolor[selectedpage],
        color: Colors.white,
        animationCurve: Curves.fastOutSlowIn,
        items: const <Widget>[
          Icon(
            Icons.home_work,
            size: 30,
            semanticLabel: 'Asset',
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.assessment_outlined,
            semanticLabel: 'Liability',
            size: 30,
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.savings,
            semanticLabel: 'Income',
            size: 30,
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.money,
            semanticLabel: 'Expense',
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.plus_one_outlined,
            semanticLabel: 'Others',
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.person_add,
            color: Color.fromARGB(255, 93, 99, 216),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedpage = index;
<<<<<<< HEAD
            controller:
            _btnController; // changing selected page as per bar index selected by the user
            _doSomething();
=======
>>>>>>> b84a36e3b5a88b5e4396b5dfe526ead908ed5532
          });
        },
      ),
    );
  }
}
