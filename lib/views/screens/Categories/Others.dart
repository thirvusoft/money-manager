// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class customOthers extends StatefulWidget {
//   const customOthers({Key? key}) : super(key: key);

//   @override
//   _customOthersState createState() => _customOthersState();
// }

// class _customOthersState extends State<customOthers> {
//   TextEditingController _textEditingController = TextEditingController();
//   var typecontroller = TextEditingController();
//   var namecontroller = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   var code;
//   bool _loading = true;
//   List icon_name = [];
//   var hexcode_dict = <String, int>{
//     ' 0xf04e1': 0xf04e1,
//     ' 0xf2ee': 0xf2ee,
//     '0xf18e': 0xf18e,
//     '0xf244': 0xf244,
//     '0xf2d6': 0xf2d6,
//     ' 0xf3f6': 0xf3f6,
//     ' 0xf3e8': 0xf3e8,
//     '0xf0617': 0xf0617,
//     '0xee35': 0xee35,
//   };
//   @override
//   void initState() {
//     super.initState();
//     listapi();
//     Future.delayed(Duration(seconds: 1), () {
//       Color.fromARGB(255, 93, 99, 216);
//       setState(() {
//         _loading = false;
//       });
//     });
//   }

// //Icon API
//   Future listapi() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var response = await http.post(
//         Uri.parse(
//             "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.icon_list?type=Others"),
//         headers: {"Authorization": prefs.getString('token') ?? ""});

//     print(
//         '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.icon_list?type=Others');

//     if (response.statusCode == 200) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       List<String> liability_icon_list = [];
//       for (var i = 0; i < json.decode(response.body)["Others"].length; i++) {
//         liability_icon_list
//             .add(jsonEncode(json.decode(response.body)["Others"][i]));
//       }
//       prefs.setStringList('liability_icon_list', liability_icon_list);
//       icon_name = prefs.getStringList("liability_icon_list")!;
//     } else if (response.statusCode == 401) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(jsonDecode('message')),
//         backgroundColor: Colors.red,
//       ));
//     } else if (response.statusCode == 403) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Permission Denied'),
//         backgroundColor: Colors.red,
//       ));
//     } else if (response.statusCode == 417) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(jsonDecode('message')),
//         backgroundColor: Colors.red,
//       ));
//     } else if (response.statusCode == 500) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(jsonDecode('message')),
//         backgroundColor: Colors.red,
//       ));
//     } else if (response.statusCode == 503) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(jsonDecode('message')),
//         backgroundColor: Colors.red,
//       ));
//     } else if (response.statusCode == 409) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(jsonDecode('message')),
//         backgroundColor: Colors.red,
//       ));
//     } else if (response.statusCode == 404) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(jsonDecode('message')),
//         backgroundColor: Colors.red,
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Invalid"),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }

//   var data;
//   get index => null;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 93, 99, 216),
//           title: Text('Others Customise Icons'),
//         ),
//         body: Center(
//           child: _loading
//               ? CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                       Color.fromARGB(255, 93, 99, 216)),
//                 )
//               : GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 3,
//                       crossAxisSpacing: 12),
//                   itemCount: icon_name.length,
//                   itemBuilder: (context, index) {
//                     code = jsonDecode(icon_name[index])[0];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 58,
//                             backgroundColor: Color.fromARGB(255, 93, 99, 216),
//                             child: IconButton(
//                                 iconSize: 30.0,
//                                 onPressed: () {
//                                   _show(context, code);
//                                 },
//                                 icon: Icon(
//                                     IconData(
//                                         hexcode_dict[jsonDecode(
//                                                 icon_name[index])[0]] ??
//                                             0XF155,
//                                         fontFamily: 'MaterialIcons'),
//                                     color: Color.fromARGB(255, 255, 255, 255))),
//                           ),
//                           SizedBox(
//                             width: 25,
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//         ));
//   }

//   void _show(BuildContext ctx, String code) {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         ),
//         isScrollControlled: true,
//         elevation: 5,
//         context: ctx,
//         builder: (ctx) => Padding(
//               padding: EdgeInsets.only(
//                   top: 15,
//                   left: 15,
//                   right: 15,
//                   bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       new Text(
//                         "Others",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       TextFormField(
//                           maxLength: 11,
//                           controller: namecontroller,
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(labelText: 'Name:'),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please enter the name";
//                             } else {
//                               return null;
//                             }
//                           }),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       RaisedButton(
//                           color: Color.fromARGB(255, 93, 99, 216),
//                           child: Text(
//                             "Submit",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed: () {
//                             if (formKey.currentState!.validate()) {
//                               cussubmit(typecontroller.text,
//                                   namecontroller.text, code);
//                             }
//                           })
//                     ]),
//               ),
//             ));
//   }

// //DataEntry API
//   Future cussubmit(type, name, code) async {
//     if (typecontroller.text.isNotEmpty || namecontroller.text.isNotEmpty) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var response = await http.post(
//           Uri.parse(
//               "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.create_new_subtype?type=Others&subtype=${name}&iconbinerycode=${code}"),
//           headers: {"Authorization": prefs.getString('token') ?? ""});
//       print(
//           '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.create_new_subtype?type=Others&subtype=${name}&iconbinerycode=${code}');

//       if (response.statusCode == 200) {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Submitted Successfully"),
//           backgroundColor: Colors.green,
//         ));
//       } else if (response.statusCode == 401) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(jsonDecode('message')),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 403) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Permission Denied'),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 417) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(jsonDecode('message')),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 500) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(jsonDecode('message')),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 503) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(jsonDecode('message')),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 409) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(jsonDecode('message')),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 404) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(jsonDecode('message')),
//           backgroundColor: Colors.red,
//         ));
//       } else {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Invalid"),
//           backgroundColor: Colors.red,
//         ));
//       }
//     }
//   }
// }
