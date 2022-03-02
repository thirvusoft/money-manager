import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/profile.dart';
import 'package:money_manager/views/screens/splash_screen.dart';

import 'views/screens/Settings/samplebutton.dart';
import 'views/screens/loginScreen.dart';
import 'package:money_manager/widgets/categoriesCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0XFFFFFFFFF)),
        home: splash_screen());
  }
}
