import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

Future profile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var response = await http.post(Uri.parse(
      "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.profile?email=${prefs.getString('email')}"));
  if (response.statusCode == 250) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mobile_number",
        json.decode(response.body)['message']['mobile_number']);
    prefs.setString(
        "full_name", json.decode(response.body)['message']['full_name']);
    prefs.setString("email", json.decode(response.body)['message']['email']);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const bottomnavigation(),
    );
  }
}

class bottomnavigation extends StatefulWidget {
  const bottomnavigation({Key? key}) : super(key: key);

  @override
  _bottomnavigationState createState() => _bottomnavigationState();
}

class _bottomnavigationState extends State<bottomnavigation> {
  int pageIndex = 0;

  final pages = [
    asset(),
    liabilitySearch(),
    expenseSearch(),
    incomeSearch(),
    othersSearch(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 15,
        width: MediaQuery.of(context).size.width / 15,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 93, 99, 216),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: Icon(
                    Icons.home_work,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  label: pageIndex == 0
                      ? Text('Assets',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 25))
                      : Text(""),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: Icon(
                    Icons.insert_chart,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  label: pageIndex == 1
                      ? Text('Liability',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 25))
                      : Text(""),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: Icon(
                    Icons.monetization_on,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  label: pageIndex == 2
                      ? Text('Expense',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 25))
                      : Text(""),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      pageIndex = 3;
                    });
                  },
                  icon: Icon(
                    Icons.savings,
                    size: 24.0,
                    color: Colors.white,
                  ),
                  label: pageIndex == 3
                      ? Text('Income',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 25))
                      : Text(""),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      pageIndex = 4;
                    });
                  },
                  icon: Icon(
                    FontAwesomeIcons.cartPlus,
//                 color: Color.fromARGB(255, 93, 99, 217)),
                    size: 24.0,
                    color: Colors.white,
                  ),
                  label: pageIndex == 4
                      ? Text('Others',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width / 25))
                      : Text(""),
                ),
              ],
            ),
            scrollDirection: Axis.horizontal));
  }
}
