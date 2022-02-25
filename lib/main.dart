import 'package:flutter/material.dart';

import 'views/screens/Settings/samplebutton.dart';
import 'views/screens/loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0XFFFFFFFFF)),
        home: login_page());
  }
}
