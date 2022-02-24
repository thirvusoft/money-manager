import 'package:flutter/material.dart';
import 'views/screens/loginScreen.dart';

// import 'package:money_manager/test2.dart';
// import 'package:money_manager/widgets/curvedNavigation.dart';
// import 'package:money_manager/widgets/subCategoriesCard.dart';
import 'package:money_manager/widgets/categoriesCard.dart';
//import 'views/screens/splashScreen.dart';
//import 'package:money_manager/test.dart';

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
