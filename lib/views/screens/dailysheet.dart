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
Future uploadimage(String path, String name, String docName) async {
  FormData formData = FormData.fromMap({
    "file": await MultipartFile.fromFile(path, filename: name),
    "docname": docName,
    "doctype": 'TS Daily Entry Sheet',
    "is_private": 0,
    "folder": "Home/Attachments"
  });

  var dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dio.options.headers["Authorization"] = prefs.getString('token') ?? "";

  var response = await dio.post(
    "${dotenv.env['API_URL']}/api/method/upload_file",
    data: formData,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var mail = prefs.getString("email");

  if (response.statusCode == 200) {
  } else {
    throw Exception('Something went wrong');
  }
}

class SecondScreen extends StatelessWidget {
  final String subtypeCode;
  final String subtypeName;
  final String type;
  SecondScreen(
      {Key? key,
      required this.type,
      required this.subtypeCode,
      required this.subtypeName})
      : super(key: key);

  var name;
  String _image = ' ';

  File? _file;
  PlatformFile? _platformFile;
  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf']);

    if (file != null) {
      //setState(() {
      _file = File(file.files.single.path!);
      _platformFile = file.files.first;
      // });
    }
  }

  Future<String> dataentry(
      type, subtypeCode, subtypeName, notes, amount, path, imgName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse(
            '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?type=${type}&subtype=${subtypeCode}&name=${subtypeName}&notes=${notes}&amount=${amount}'),
        headers: {"Authorization": prefs.getString('token') ?? ""});

    if (response.statusCode == 200) {
      var docName = json.decode(response.body)['docname'];
      if (path.isNotEmpty || imgName.isNotEmpty || docName.isNotEmpty) {
        uploadimage(path, imgName, docName);
      }

      return json.decode(response.body)['message'];
    } else if (response.statusCode == 401) {
      return json.decode(response.body)['message'];
    } else if (response.statusCode == 403) {
      return 'Permission Denied';
    } else if (response.statusCode == 417) {
      return json.decode(response.body)['message'];
    } else if (response.statusCode == 500) {
      return json.decode(response.body)['message'];
    } else if (response.statusCode == 503) {
      return json.decode(response.body)['message'];
    } else if (response.statusCode == 409) {
      return json.decode(response.body)['message'];
    } else if (response.statusCode == 429) {
      return json.decode(response.body)['message'];
    } else if (response.statusCode == 404) {
      return json.decode(response.body)['message'];
    } else {
      return 'Invalid';
    }
  }

  TextEditingController _textEditingController = TextEditingController();
  var typecontroller = TextEditingController();
  var subtypecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var notescontroller = TextEditingController();
  var amountcontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var filecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 93, 99, 216),
        title: Text(
          subtypeName,
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
            ),
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
                        if (_formKey.currentState!.validate()) {
                          var msg = dataentry(
                            type,
                            subtypeCode,
                            namecontroller.text,
                            notescontroller.text,
                            amountcontroller.text,
                            _platformFile!.path ?? '',
                            _platformFile!.name,
                          );

                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Successfully  Completed"),
                            backgroundColor: Colors.green,
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Invalid"),
                            backgroundColor: Colors.red,
                          ));
                        }

                        typecontroller.clear();
                        namecontroller.clear();
                        notescontroller.clear();
                        amountcontroller.clear();
                        datecontroller.clear();
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
