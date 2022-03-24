import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_manager/views/screens/Homescreen/Asset.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Homescreen/expensesSearch.dart';
import 'package:money_manager/views/screens/Homescreen/incomeSearch.dart';
import 'package:money_manager/views/screens/Homescreen/liabilitySearch.dart';
import 'package:money_manager/views/screens/Homescreen/othersSearch.dart';
import 'package:money_manager/views/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class bottomnavigation extends StatefulWidget {
  const bottomnavigation({Key? key}) : super(key: key);

  @override
  _bottomnavigationState createState() => _bottomnavigationState();
}

class _bottomnavigationState extends State<bottomnavigation> {
  int currentIndex = 0;
  List widgetOptions = [
    asset(),
    liabilitySearch(),
    expenseSearch(),
    incomeSearch(),
    othersSearch(),
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
            title: Text("Assets",
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
        ],
      ),
    );
  }

  Future profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(
        "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.profile?email=${prefs.getString('email')}"));
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("mobile_number",
          json.decode(response.body)['message']['mobile_number']);
      prefs.setString(
          "full_name", json.decode(response.body)['message']['full_name']);
      prefs.setString("email", json.decode(response.body)['message']['email']);
    }
  }
}
