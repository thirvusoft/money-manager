// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class categoriesCard extends StatefulWidget {
  const categoriesCard({Key? key}) : super(key: key);

  @override
  _categoriesCardState createState() => _categoriesCardState();
}

// ignore: camel_case_types
class _categoriesCardState extends State<categoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Card(
              color: Colors.amber,
              child: Container(
                height: 100,
                width: 500,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Property"),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                    ),
                    Padding(
                      padding: EdgeInsets.zero,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text("Portable"),
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
