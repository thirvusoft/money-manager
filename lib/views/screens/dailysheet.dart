import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iconsax/iconsax.dart';
import 'package:money_manager/views/screens/Homescreen/Asset.dart';
import 'package:money_manager/widgets/BottomNavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// class dailysheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 93, 99, 216),
//           title: Text(
//             subtypesname,
//           ),
//         ),
//         body: MyCustomForm(),
//       ),
//     );
//   }
// }

class MyCustomForm extends StatefulWidget {
  MyCustomForm(s, subtypescode, subtypesname);

  // String type,
  //  String subtypescode, String subtypesname);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm>
    with SingleTickerProviderStateMixin {
  var name;
  String _image = ' ';
  late String type;
  late String subtypescode;
  late String subtypesname;
  MyCustomForm(type, subtypescode, subtypesname);
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
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(subtypesname),
      ),
      body: SingleChildScrollView(
        child: Form(
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
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                                    color:
                                                        Colors.grey.shade500),
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
                          // _file, _platformFile
                          if (_formKey.currentState!.validate()) {
                            print(subtypescode);
                            dataentry(
                              typecontroller.text,
                              subtypescode,
                              namecontroller.text,
                              notescontroller.text,
                              amountcontroller.text,
                            );
                            // uploadimage(
                            //     _platformFile!.path ?? '', _platformFile!.name);
                            typecontroller.clear();
                            namecontroller.clear();
                            notescontroller.clear();
                            amountcontroller.clear();
                            datecontroller.clear();
                          }
                        })),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future dataentry(type, subtypescode, name, notes, amount) async {
    if (typecontroller.text.isNotEmpty ||
        subtypecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty) {
      print(subtypescode);
      print(type);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.post(
          Uri.parse(
              '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=${type}&Subtype=${subtypescode}&Name=${name}&Notes=${notes}&Amount=${amount}'),
          headers: {"Authorization": prefs.getString('token') ?? ""});
      print("dataentery code");
      print(
          '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=${type}&Subtype=${subtypescode}&Name=${name}&Notes=${notes}&Amount=${amount}');
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.green,
        ));
      } else if (response.statusCode == 401) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 403) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission Denied'),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 417) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 500) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 503) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 409) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 429) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 404) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigation()),
        );

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
    // print("object");
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

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
