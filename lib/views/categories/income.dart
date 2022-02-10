// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class incomeCard extends StatefulWidget {
  const incomeCard({Key? key}) : super(key: key);

  @override
  _incomeCardState createState() => _incomeCardState();
}

// ignore: camel_case_types
class _incomeCardState extends State<incomeCard> {
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
                      padding: EdgeInsets.zero,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Property",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Portable",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Portable",
                            style: TextStyle(color: Colors.white)),
                      ),
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
