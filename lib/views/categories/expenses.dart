// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class expensesCard extends StatefulWidget {
  const expensesCard({Key? key}) : super(key: key);

  @override
  _expensesCardState createState() => _expensesCardState();
}

// ignore: camel_case_types
class _expensesCardState extends State<expensesCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Card(
              color: Colors.blue.shade900,
              child: Container(
                height: 100,
                width: 500,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Property",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Portable",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
