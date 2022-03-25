import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money_manager/views/screens/Categories/liability.dart';
import 'package:money_manager/views/screens/dailysheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dio/dio.dart';
import 'dart:io';

// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/views/screens/profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Categories/Asset.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class asset extends StatefulWidget {
  const asset({Key? key}) : super(key: key);

  @override
  _assetState createState() => _assetState();
}

class _assetState extends State<asset> with SingleTickerProviderStateMixin {
  String _image = ' ';
  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }
    loadingController.forward();
  }

  @override
  void initState() {
    super.initState();

    listapi();
    Future.delayed(Duration(seconds: 1), () {
      Color.fromARGB(255, 93, 99, 216);

      setState(() {
        _loading = false;
      });
    });
  }

  TextEditingController _textEditingController = TextEditingController();

  var typecontroller = TextEditingController();
  var subtypecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var notescontroller = TextEditingController();
  var amountcontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var subtypescode;
  var subtypesname;

  final formKey = GlobalKey<FormState>();

  bool _loading = true;
  List icon_nameOnSearch = [];
  List icon_name = [];
  var hexcode_dict = <String, int>{
    ' 0xf1dd': 0xf1dd,
    ' 0xf1dd': 0xf1dd,
    '0xf1dd': 0xf1dd,
    '0xf05e7': 0xf05e7,
    '0xee62': 0xee62,
    '0xf447': 0xf447,
    '0xef06': 0xef06,
    '0xf05ce': 0xf05ce,
    '0xf42b': 0xf42b,
    '0xf1af': 0xf1af,
    '0xee35': 0xee35,
    '0xf2e9': 0xf2e9,
    '0xf108': 0xf108,
    '0xf05ce': 0xf05ce
  };

// Icon API
  Future listapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.withsubtype?Type=Asset"),
        headers: {"Authorization": prefs.getString('token') ?? ""});

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> liability_icon_list = [];
//      print(liability_icon_list);

      for (var i = 0; i < json.decode(response.body)["Asset"].length; i++) {
        liability_icon_list
            .add(jsonEncode(json.decode(response.body)["Asset"][i]));
      }
      prefs.setStringList('liability_icon_list', liability_icon_list);
      icon_name = prefs.getStringList("liability_icon_list")!;

      setState(() => _loading = true);
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.red,
      ));
    } else if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permission Denied'),
        backgroundColor: Colors.red,
      ));
    } else if (response.statusCode == 417) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.red,
      ));
    } else if (response.statusCode == 500) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.red,
      ));
    } else if (response.statusCode == 503) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.red,
      ));
    } else if (response.statusCode == 409) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.red,
      ));
    } else if (response.statusCode == 404) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid"),
        backgroundColor: Colors.red,
      ));
    }
  }

  var data;

  get index => null;
  @override
  Widget build(BuildContext context) {
    var file;
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profiles(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
              ),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 93, 99, 216),
          automaticallyImplyLeading: false,
          title: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  value.trimLeft();
                  icon_nameOnSearch.clear();
                  for (var i = 0; i < icon_name.length; i++) {
                    data = jsonDecode(icon_name[i])[0];

                    if (data
                        .toLowerCase()
                        .contains(value.trim().toLowerCase())) {
                      icon_nameOnSearch.add(icon_name[i]);
                    }
                  }
                });
              },
              controller: _textEditingController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 93, 99, 216),
                  )),
            ),
          ),
        ),
        body: Center(
            child: _loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 93, 99, 216)),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 20),
                    itemCount: _textEditingController.text.isNotEmpty
                        ? icon_nameOnSearch.length
                        : icon_name.length,
                    itemBuilder: (context, index) {
                      var row = [];
                      if (icon_nameOnSearch.length != 0) {
                        row = icon_nameOnSearch;
                        print(row);
                      } else {
                        row = icon_name;
                        print(row);
                      }
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Center(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        subtypescode =
                                            jsonDecode(row[index])[2];
                                        subtypesname =
                                            jsonDecode(row[index])[0];

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                dailysheet(subtypescode),
                                          ),
                                        );
                                      },
                                      label: Text(
                                        _textEditingController.text.isNotEmpty
                                            ? jsonDecode(row[index])[0]
                                            : jsonDecode(row[index])[0],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            letterSpacing: .7,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      icon: Icon(
                                          IconData(
                                              hexcode_dict[jsonDecode(
                                                      row[index])[1]] ??
                                                  0XF155,
                                              fontFamily: 'MaterialIcons'),
                                          color: Color.fromARGB(
                                              255, 93, 99, 216)))),
                            ],
                          ));
                    })),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add, semanticLabel: 'Customise icon'),
            backgroundColor: Color.fromARGB(255, 93, 99, 216),
            onPressed: () {
              _loading = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => customAsset(),
                ),
              );
            }));
  }
}
  // void _show(BuildContext ctx, subtypescode, subtypesname) {
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //       ),
  //       isScrollControlled: true,
  //       elevation: 5,
  //       context: ctx,
  //       builder: (ctx) => Padding(
  //             padding: EdgeInsets.only(
  //                 top: 15,
  //                 left: 15,
  //                 right: 15,
  //                 bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
  //             child: Form(
  //               key: formKey,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text("Asset",
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(fontSize: 25)),
  //                   ),
  //                   Text(subtypesname, style: TextStyle(fontSize: 20)),
  //                   TextFormField(
  //                       controller: namecontroller,
  //                       decoration: InputDecoration(labelText: 'Name'),
  //                       validator: (value) {
  //                         if (value!.isEmpty) {
  //                           return "Please enter the name";
  //                         } else {
  //                           return null;
  //                         }
  //                       }),
  //                   TextFormField(
  //                     controller: notescontroller,
  //                     decoration: InputDecoration(labelText: 'Notes'),
  //                   ),
  //                   TextFormField(
  //                       controller: amountcontroller,
  //                       decoration: InputDecoration(labelText: 'Amount'),
  //                       keyboardType: TextInputType.number,
  //                       validator: (value) {
  //                         if (value!.isEmpty) {
  //                           return "Please enter the amount";
  //                         } else {
  //                           return null;
  //                         }
  //                       }),
  //                   // TextButton(
  //                   //     onPressed: () {
  //                   //       _onAlertWithCustomContentPressed(context);
  //                   //     },
  //                   //     child: const Text(
  //                   //       "Upload",
  //                   //       style:
  //                   //           TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  //                   //     )),
  //                   GestureDetector(
  //                     onTap: selectFile,
  //                     child: Padding(
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: 40.0, vertical: 20.0),
  //                         child: DottedBorder(
  //                           borderType: BorderType.RRect,
  //                           radius: Radius.circular(10),
  //                           dashPattern: [10, 4],
  //                           strokeCap: StrokeCap.round,
  //                           color: Colors.blue.shade400,
  //                           child: Container(
  //                             width: double.infinity,
  //                             child: Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Icon(
  //                                   Iconsax.folder_open,
  //                                   color: Colors.blue,
  //                                   size: 40,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         )),
  //                   ),
  //                   _platformFile != null
  //                       ? Container(
  //                           child: _loading
  //                               ? CircularProgressIndicator(
  //                                   valueColor: AlwaysStoppedAnimation<Color>(
  //                                       Color.fromARGB(255, 93, 99, 216)),
  //                                 )
  //                               : Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Text(
  //                                       'Selected File',
  //                                       style: TextStyle(
  //                                         color: Colors.grey.shade400,
  //                                         fontSize: 15,
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                         padding: EdgeInsets.all(8),
  //                                         decoration: BoxDecoration(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(100),
  //                                             color: Colors.white,
  //                                             boxShadow: [
  //                                               BoxShadow(
  //                                                 color: Colors.grey.shade200,
  //                                                 offset: Offset(0, 1),
  //                                                 blurRadius: 3,
  //                                                 spreadRadius: 2,
  //                                               )
  //                                             ]),
  //                                         child: Row(
  //                                           children: [
  //                                             SizedBox(
  //                                               width: 10,
  //                                             ),
  //                                             Expanded(
  //                                               child: Column(
  //                                                 crossAxisAlignment:
  //                                                     CrossAxisAlignment.start,
  //                                                 children: [
  //                                                   Text(
  //                                                     _platformFile!.name,
  //                                                     style: TextStyle(
  //                                                         fontSize: 13,
  //                                                         color: Colors.black),
  //                                                   ),
  //                                                   SizedBox(
  //                                                     height: 5,
  //                                                   ),
  //                                                   Text(
  //                                                     '${(_platformFile!.size / 1024).ceil()} KB',
  //                                                     style: TextStyle(
  //                                                         fontSize: 13,
  //                                                         color: Colors
  //                                                             .grey.shade500),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         )),
  //                                     SizedBox(
  //                                       height: 20,
  //                                     ),
  //                                   ],
  //                                 ))
  //                       : Container(),
  //                   SizedBox(
  //                     height: 150,
  //                   ),

  //                   RaisedButton(
  //                       color: Color.fromARGB(255, 93, 99, 216),
  //                       child: Text(
  //                         "Submit",
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                       onPressed: () {
  //  uploadimage();
  // if (formKey.currentState!.validate()) {
  //   dataentry(
  //     typecontroller.text,
  //     subtypescode,
  //     namecontroller.text,
  //     notescontroller.text,
  //     amountcontroller.text,
  //   );

  //   // typecontroller.clear();
  //   namecontroller.clear();
  //   notescontroller.clear();
  //   amountcontroller.clear();
  //   datecontroller.clear();
  // }
  //                       })
  //                 ],
  //               ),
  //             ),
  //           ));
  // }

//   Future dataentry(type, subtypescode, name, notes, amount) async {
//     if (typecontroller.text.isNotEmpty ||
//         namecontroller.text.isNotEmpty ||
//         notescontroller.text.isNotEmpty ||
//         amountcontroller.text.isNotEmpty) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var response = await http.post(
//           Uri.parse(
//               '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Asset&Subtype=${subtypescode}&Name=${name}&Notes=${notes}&Amount=${amount}'),
//           headers: {"Authorization": prefs.getString('token') ?? ""});
//       //print(response.statusCode);

//       if (response.statusCode == 200) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(json.decode(response.body)['message']),
//           backgroundColor: Colors.green,
//         ));
//       } else if (response.statusCode == 401) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(json.decode(response.body)['message']),
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
//           content: Text(json.decode(response.body)['message']),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 500) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(json.decode(response.body)['message']),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 503) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(json.decode(response.body)['message']),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 409) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(json.decode(response.body)['message']),
//           backgroundColor: Colors.red,
//         ));
//       } else if (response.statusCode == 404) {
//         Navigator.pop(context);

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(json.decode(response.body)['message']),
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

//   Future uploadfile(File img64) async {
//     var bytes = img64.readAsBytesSync();
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     var response = await http.post(
//       Uri.parse(
//           "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.upload_profile_image"),
//       headers: {"Authorization": prefs.getString('token') ?? ""},
//       body: {"file", bytes},
//       encoding: Encoding.getByName("utf-8"),
//     );
//     return response.body;
//   }

//   Future uploadimage() async {
//     FormData formData = FormData.fromMap({
//       "file": await MultipartFile.fromFile(
//         '/data/user/0/com.example.money_manager/cache/file_picker/Employer Survey.pdf',
//         filename: 'Employer Survey.pdf',
//       ),
//       "docname": 'barathpalanisamy2002@gmail.com',
//       "doctype": 'User',
//       "is_private": 0,
//       "folder": "Home/Attachments"
//     });
//     print(formData);
//     var dio = Dio();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     dio.options.headers["Authorization"] = prefs.getString('token') ?? "";
//     var response = await dio.post(
//       "http://192.168.116.158:8002/api/method/upload_file",
//       data: formData,
//     );
//     print(dio);
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//     } else {
//       throw Exception('Something went wrong');
//     }
//     // print("ryyrg");
//     // var bytes = "";

//     // var decodedBytes = base64Decode(bytes);
//     // var change = base64.encode(decodedBytes);
//     // print(decodedBytes);
//     // print(change);
//     // //  print(Uint8List base64Decode(String source) => base64.decode(change));

//     // SharedPreferences prefs = await SharedPreferences.getInstance();

//     // var response = await http.post(
//     //     Uri.parse(
//     //         "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.upload_profile_image"),
//     //     headers: {"Authorization": prefs.getString('token') ?? ""},
//     //     body: {"file": bytes});
//     // print(response.statusCode);
//     // if (response.statusCode == 200) {
//     //   print("rgt");
//     // }
//     // return response.body;
//   }
// }
