// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:money_manager/views/categories/assets.dart';
import 'package:money_manager/views/categories/expenses.dart';
import 'package:money_manager/views/categories/income.dart';
import 'package:money_manager/views/categories/liability.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);
  @override
  _home_pageState createState() => _home_pageState();
}

// ignore: camel_case_types
class _home_pageState extends State<home_page> {
  //   with SingleTickerProviderStateMixin {
  // late TabController _tabcontroller;
  // void initstate() {
  //   _tabcontroller = TabController(length: 4, vsync: this, initialIndex: 0);
  //   super.initState();
  // }

  // void dispose() {
  //   _tabcontroller.dispose();
  //   super.dispose();
  int activeIndex = 0;

  final tabs = [assetsCard(), liabilityCard(), incomeCard(), expensesCard()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.notifications_on,
                  size: 30.0,
                  color: Colors.blue.shade900,
                ),
              ],
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (index) {
                setState(() {
                  activeIndex = index;
                });
              },
              //controller: _tabcontroller,
              indicatorColor: Colors.blue.shade900,
              tabs: [
                Tab(
                  child: Text(
                    "Assets",
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                ),
                Tab(
                  child: Text(
                    "Liabilities",
                    style: TextStyle(
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Incomes",
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                ),
                Tab(
                  child: Text(
                    "Expenses",
                    style: TextStyle(color: Colors.blue.shade900),
                  ),
                ),
              ],
            ),
          ),

          body: tabs[activeIndex],

          // body: TabBarView(
          //   //controller: _tabcontroller,
          //   children: [categoriesCard()],
          // ),
        ),
      ),
    );
  }
}
