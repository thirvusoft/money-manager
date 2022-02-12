// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class liabilityCard extends StatefulWidget {
  const liabilityCard({Key? key}) : super(key: key);

  @override
  _liabilityCardState createState() => _liabilityCardState();
}

// ignore: camel_case_types
class _liabilityCardState extends State<liabilityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 500,
      child: Scaffold(
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            Card(
              child: ListTile(
                title: Text("Property"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Protability"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Protability"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Protability"),
              ),
            )
          ],
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          itemExtent: 100,
        ),
      ),
    );
  }
}
