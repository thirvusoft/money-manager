import 'package:flutter/material.dart';
import 'package:money_manager/views/categories/categoriesList.dart';
//import 'package:money_manager/views/categories/categoriesDetails.dart';
//import 'package:money_manager/views/categories/categoriesList.dart';
import 'package:money_manager/widgets/subCategoriesCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: AllFieldsForm());
  }
}
