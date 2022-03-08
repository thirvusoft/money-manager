import 'package:flutter/material.dart';

import 'package:money_manager/views/screens/profile.dart';
import 'package:money_manager/views/screens/splash_screen.dart';

import 'views/screens/Categories/Asset.dart';
import 'views/screens/Homescreen/expensesSearch.dart';
import 'widgets/BottomNavigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0XFFFFFFFFF)),
        home: customAsset());
  }
}
