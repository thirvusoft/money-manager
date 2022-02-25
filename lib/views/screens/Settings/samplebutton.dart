import 'package:flutter/material.dart';
import 'Asset.dart';
import 'liability.dart';
import 'Income.dart';
import 'Expense.dart';
import 'Others.dart';

class navigation extends StatefulWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  _navigationState createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          new RaisedButton(
            child: new Text("Asset"),
            color: Colors.blueAccent[600],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Asset()),
              );
            },
          ),
          new RaisedButton(
            child: new Text("Liability"),
            color: Colors.blueAccent[600],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Liability()),
              );
            },
          ),
          new RaisedButton(
            child: new Text("Income"),
            color: Colors.blueAccent[600],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Income()),
              );
            },
          ),
          new RaisedButton(
            child: new Text("Expense"),
            color: Colors.blueAccent[600],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Expense()),
              );
            },
          ),
          new RaisedButton(
            child: new Text("others"),
            color: Colors.blueAccent[600],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Others()),
              );
            },
          ),
        ],
      ),
    );
  }
}
