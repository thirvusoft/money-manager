import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// class daily extends StatelessWidget {
//  x

//   @override
//   Widget build(BuildContext context) {
//     final appTitle = 'Flutter Form Demo';
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: appTitle,
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 93, 99, 216),
//           title: Text(
//             subtypesname,
//           ),
//         ),
//         body: data(),
//       ),
//     );
//   }
// }

class data extends StatefulWidget {
  late String type;
  late String subtypescode;
  late String subtypesname;
  data(this.type, this.subtypescode, this.subtypesname);
  @override
  dataState createState() {
    return dataState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class dataState extends State<data> with SingleTickerProviderStateMixin {
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

  TextEditingController _textEditingController = TextEditingController();

  var typecontroller = TextEditingController();
  var subtypecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var notescontroller = TextEditingController();
  var amountcontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var subtypescode;
  var subtypesname;

  final dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 93, 99, 216),
        title: Text(
          subtypesname,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the name";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: notescontroller,
                decoration: InputDecoration(labelText: 'Notes'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the notes";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                controller: amountcontroller,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the amount";
                  } else {
                    return null;
                  }
                }),
            TextFormField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(labelText: 'Reminder Date'),
                style: TextStyle(),
                onTap: () async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );
                  builder:
                  (BuildContext context, Widget child) {
                    return Theme(
                      data: ThemeData().copyWith(
                          colorScheme: ColorScheme.dark(
                              primary: Colors.red, surface: Colors.red)),
                      child: child,
                    );
                  };
                  dateController.text = date.toString().substring(0, 10);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the date";
                  } else {
                    return null;
                  }
                }),
            GestureDetector(
              onTap: selectFile,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    dashPattern: [10, 4],
                    strokeCap: StrokeCap.round,
                    color: Color.fromARGB(255, 93, 99, 216),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.folder_open,
                            color: Color.fromARGB(255, 93, 99, 216),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            _platformFile != null
                ? Container(
                    child: _loading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color.fromARGB(255, 93, 99, 216)),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected File',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade200,
                                          offset: Offset(0, 1),
                                          blurRadius: 3,
                                          spreadRadius: 2,
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _platformFile!.name,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${(_platformFile!.size / 1024).ceil()} KB',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.shade500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                : Container(),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Center(
                    child: RaisedButton(
                        color: Color.fromARGB(255, 93, 99, 216),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          print("test");
                          // uploadimage(
                          //     _platformFile!.path ?? '', _platformFile!.name);
                          // _file, _platformFile
                          if (_formKey.currentState!.validate()) {
                            dataentry(
                              typecontroller.text,
                              subtypescode,
                              namecontroller.text,
                              notescontroller.text,
                              amountcontroller.text,
                            );

                            // typecontroller.clear();
                            namecontroller.clear();
                            notescontroller.clear();
                            amountcontroller.clear();
                            datecontroller.clear();
                          }
                        })))
          ],
        ),
      ),
    );
  }

  //           RaisedButton(
  //               color: Color.fromARGB(255, 93, 99, 216),
  //               child: Text(
  //                 "Submit",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () {
  //                 print("test");
  //                 uploadimage(_file, _platformFile!.name);
  //                 // _file, _platformFile
  //                 if (_formKey.currentState!.validate()) {
  //                   dataentry(
  //                     typecontroller.text,
  //                     subtypescode,
  //                     namecontroller.text,
  //                     notescontroller.text,
  //                     amountcontroller.text,
  //                   );

  //                   // typecontroller.clear();
  //                   namecontroller.clear();
  //                   notescontroller.clear();
  //                   amountcontroller.clear();
  //                   datecontroller.clear();
  //                 }
  //               })
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future dataentry(type, subtypescode, name, notes, amount) async {
    if (typecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.post(
          Uri.parse(
              '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=${type}&Subtype=${subtypescode}&Name=${name}&Notes=${notes}&Amount=${amount}'),
          headers: {"Authorization": prefs.getString('token') ?? ""});
      //print(response.statusCode);
      print(
          '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=${type}&Subtype=${subtypescode}&Name=${name}&Notes=${notes}&Amount=${amount}');

      if (response.statusCode == 200) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.green,
        ));
      } else if (response.statusCode == 401) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 403) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission Denied'),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 417) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 500) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 503) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 409) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 429) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 404) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future uploadfile(File img64) async {
    var bytes = img64.readAsBytesSync();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(
      Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.upload_profile_image"),
      headers: {"Authorization": prefs.getString('token') ?? ""},
      body: {
        "file",
      },
      encoding: Encoding.getByName("utf-8"),
    );
    return response.body;
  }

//var _file, var _platformFile
  Future uploadimage(String path, String name) async {
    print("object");
    print(path);
    print(name);
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
          // '/data/user/0/com.example.money_manager/cache/file_picker/Employer Survey.pdf',
          // filename: 'Employer Survey.pdf',
          path,
          filename: name),
      "docname": 'mail',
      "doctype": 'User',
      "is_private": 0,
      "folder": "Home/Attachments"
    });
    print(formData);

    var dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] = prefs.getString('token') ?? "";

    var response = await dio.post(
      "${dotenv.env['API_URL']}/api/method/upload_file",
      data: formData,
    );
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var mail = prefs.getString("email");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    mail = _prefs.getString("email");
    print(mail);
    print(dio);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      throw Exception('Something went wrong');
    }
  }
}
