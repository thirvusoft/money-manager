// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:money_manager/widgets/subCategoriesCard.dart';

class assetsCard extends StatefulWidget {
  const assetsCard({Key? key}) : super(key: key);

  @override
  _assetsCardState createState() => _assetsCardState();
}

// int activeIndex = 0;
// final tabs = [
//   Leaf(),
// ];

// ignore: camel_case_types
class _assetsCardState extends State<assetsCard> {
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
              child: ListTile(title: Text("Property")),
            ),
            SizedBox(
              height: 19,
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
