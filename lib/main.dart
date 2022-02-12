import 'package:flutter/material.dart';
import 'package:money_manager/widgets/subCategoriesCard.dart';
import 'views/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: Color(0XFFFFFFFFF)),
      home: splash_screen(),
    );
  }
}
