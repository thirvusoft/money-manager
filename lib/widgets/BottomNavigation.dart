import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Homescreen/expensesSearch.dart';
import 'package:money_manager/views/screens/Homescreen/incomeSearch.dart';
import 'package:money_manager/views/screens/Homescreen/liabilitySearch.dart';
import 'package:money_manager/views/screens/Homescreen/othersSearch.dart';
import 'package:money_manager/views/screens/Homescreen/search.dart';
import 'package:money_manager/views/screens/profile.dart';

void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedpage = 0; //initial value
  final _pageOptions = [
    searchbar(),
    liabilitySearch(),
    expenseSearch(),
    incomeSearch(),
    othersSearch(),
    ProfilePage(),
  ]; // listing of all 3 pages index wise
  final bgcolor = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ]; // changing color as per active index value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[
          selectedpage], // initial value is 0 so HomePage will be shown linearToEaseOut
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        buttonBackgroundColor: Colors.white,
        backgroundColor: bgcolor[selectedpage],
        color: Colors.white,
        animationCurve: Curves.fastOutSlowIn,
        items: const <Widget>[
          Icon(
            Icons.home_work,
            size: 30,
            semanticLabel: 'Asset',

            // color: Colors.black,
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.assessment_outlined, semanticLabel: 'Liability',
            size: 30,
            // color: Colors.black,
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.savings,
            semanticLabel: 'Income',
            size: 30,
            // color: Colors.black,
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.money,
            semanticLabel: 'Expense',
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.plus_one_outlined,
            semanticLabel: 'Others',
            color: Color.fromARGB(255, 93, 99, 216),
          ),
          Icon(
            Icons.person_add,
            color: Color.fromARGB(255, 93, 99, 216),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedpage =
                index; // changing selected page as per bar index selected by the user
          });
        },
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:money_manager/views/screens/profile.dart';
// import '../views/screens/Homescreen/expensesSearch.dart';
// import '../views/screens/Homescreen/incomeSearch.dart';
// import '../views/screens/Homescreen/liabilitySearch.dart';
// import '../views/screens/Homescreen/othersSearch.dart';
// import '../views/screens/Homescreen/search.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = <Widget>[
//     searchbar(),
//     liabilitySearch(),
//     expenseSearch(),
//     incomeSearch(),
//     othersSearch(),
//     ProfilePageDesign(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home_work,
//               color: Color.fromARGB(255, 93, 99, 216),
//             ),
//             label: 'Asset',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.assessment_outlined,
//               color: Color.fromARGB(255, 93, 99, 216),
//             ),
//             label: 'Liability',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.savings,
//               color: Color.fromARGB(255, 93, 99, 216),
//             ),
//             label: 'Expense',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.money, color: Color.fromARGB(255, 93, 99, 216)),
//             label: 'Income',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.plus_one_outlined,
//                 color: Color.fromARGB(255, 93, 99, 216)),
//             label: 'Others',
//           ),
//           BottomNavigationBarItem(
//             icon:
//                 Icon(Icons.person_add, color: Color.fromARGB(255, 93, 99, 216)),
//             label: 'Profile',
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//     );
//   }
// }
