// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class incomeCard extends StatefulWidget {
  const incomeCard({Key? key}) : super(key: key);

  @override
  _incomeCardState createState() => _incomeCardState();
}

// ignore: camel_case_types
class _incomeCardState extends State<incomeCard> {
  // List<String> images = [
  //   "Property",
  //   "Protable",
  //   "Property",
  //   "Protable",
  //   "Property",
  //   "Protable",
  //   "Property",
  //   "Protable",
  //   "Property",
  //   "Protable",
  // ];
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     SizedBox(
    //       height: 100,
    //       child: ListView.builder(
    //         itemCount: images.length,
    //         scrollDirection: Axis.horizontal,
    //         itemBuilder: (context, index) => Container(
    //           height: 100,
    //           width: 100,
    //           margin: EdgeInsets.all(10),
    //           child: Center(
    //             child: Text(images[index]),
    //           ),
    //           color: Colors.,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
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
                title: Text("Property"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Property"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Property"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Property"),
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
