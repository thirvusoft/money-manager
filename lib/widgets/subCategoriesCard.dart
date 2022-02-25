// import 'package:flutter/material.dart';

// class Leaf extends StatefulWidget {
//   const Leaf({Key? key}) : super(key: key);

//   @override
//   _LeafState createState() => _LeafState();
// }

// class _LeafState extends State<Leaf> {
//   final List<Map<String, dynamic>> _allUsers = [
//     {"id": 1, "name": "Andy", "age": 29},
//     {"id": 2, "name": "Aragon", "age": 40},
//     {"id": 3, "name": "Bob", "age": 5},
//     {"id": 4, "name": "Barbara", "age": 35},
//     {"id": 5, "name": "Candy", "age": 21},
//     {"id": 6, "name": "Colin", "age": 55},
//     {"id": 7, "name": "Audra", "age": 30},
//     {"id": 8, "name": "Banana", "age": 14},
//     {"id": 9, "name": "Caversky", "age": 100},
//     {"id": 10, "name": "Becky", "age": 32},
//   ];

//   List<Map<String, dynamic>> _foundUsers = [];
//   @override
//   initState() {
//     _foundUsers = _allUsers;
//     super.initState();
//   }

//   void _runFilter(String enteredKeyword) {
//     List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       results = _allUsers;
//     } else {
//       results = _allUsers
//           .where((user) =>
//               user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
//           .toList();
//     }

//     setState(() {
//       _foundUsers = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//         // appBar: AppBar(
//         //   title: const Text('Kindacode.com'),
//         // ),
//         body: Center(
//       child: Container(
//         margin: const EdgeInsets.all(10.0),
//         color: Colors.white,
//         width: 280,
//         height: 480,
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               onChanged: (value) => _runFilter(value),
//               decoration: const InputDecoration(
//                   labelText: 'Search', suffixIcon: Icon(Icons.search)),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: _foundUsers.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: _foundUsers.length,
//                       itemBuilder: (context, index) => Card(
//                         key: ValueKey(_foundUsers[index]["id"]),
//                         color: Colors.blue,
//                         elevation: 4,
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: ListTile(
//                           leading: Text(
//                             _foundUsers[index]["id"].toString(),
//                             style: const TextStyle(fontSize: 24),
//                           ),
//                           title: Text(_foundUsers[index]['name']),
//                           subtitle: Text(
//                               '${_foundUsers[index]["age"].toString()} years old'),
//                         ),
//                       ),
//                     )
//                   : const Text(
//                       'No results found',
//                       style: TextStyle(fontSize: 24),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
