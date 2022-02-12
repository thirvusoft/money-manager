// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:money_manager/views/categories/assets.dart';
import 'package:money_manager/views/categories/expenses.dart';
import 'package:money_manager/views/categories/income.dart';
import 'package:money_manager/views/categories/liability.dart';

class categoriesCard extends StatefulWidget {
  const categoriesCard({Key? key}) : super(key: key);

  @override
  _categoriesCardState createState() => _categoriesCardState();
}

// ignore: camel_case_types
class _categoriesCardState extends State<categoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          for (int i = 0; i < 10; i++) assetsCard(),
          liabilityCard(),
          incomeCard(),
          expensesCard(),
        ],
      ),
    );
  }
}
