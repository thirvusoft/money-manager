import 'package:flutter/material.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: Text("Data"),
      )),
    );
  }
}
