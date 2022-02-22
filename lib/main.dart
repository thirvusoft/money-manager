import 'package:flutter/material.dart';

import 'package:money_manager/views/categories/assets.dart';
import 'package:money_manager/views/categories/others.dart';
import 'package:money_manager/widgets/curvedNavigation.dart';

import 'views/categories/searchbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0XFFFFFFFFF)),
        home: MainScreen());
  }
}
