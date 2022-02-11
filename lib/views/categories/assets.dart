// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class assetsCard extends StatefulWidget {
  const assetsCard({Key? key}) : super(key: key);

  @override
  _assetsCardState createState() => _assetsCardState();
}

// ignore: camel_case_types
class _assetsCardState extends State<assetsCard> {
  final index = 2;
  List<String> text = ["Property", "Protability"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                height: 100,
                width: 100,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(text[index]),
                ),
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
