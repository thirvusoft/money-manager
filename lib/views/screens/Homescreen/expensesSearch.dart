import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money_manager/views/screens/Categories/liability.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

import '../Categories/Expense.dart';
import '../dailysheet.dart';

class expenseSearch extends StatefulWidget {
  const expenseSearch({Key? key}) : super(key: key);

  @override
  _expenseSearchState createState() => _expenseSearchState();
}

class _expenseSearchState extends State<expenseSearch> {
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
    ' 0xf2e9': 0xf2e9,
    ' 0xf172': 0xf172,
    '0xf37d': 0xf37d,
    '0xf3cf': 0xf3cf,
    '0xf37f': 0xf37f,
    ' 0xef2d': 0xef2d,
    ' 0xf05f0': 0xf05f0,
    '0xef4c': 0xef4c,
    '0xf24e': 0xf24e,
    '0xf076': 0xf076,
    '0xf37f': 0xf37f,
    ' 0xf28c': 0xf28c,
    ' 0xf28d': 0xf28d,
    '0xf0f2': 0xf0f2,
    '0xf041': 0xf041,
    '0xef0d': 0xef0d,
    '0xf33c': 0xf33c,
    ' 0xf108': 0xf108,
    ' 0xf06a4': 0xf06a4,
    '0xf109': 0xf109,
    '0xe2e4': 0xe2e4,
    '0xf068b': 0xf068b,
    '0xf05ce': 0xf05ce
  };

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

//Icon API
  Future listapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.subtype_list?type=Expense"),
        headers: {"Authorization": prefs.getString('token') ?? ""});

    print(
        '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.subtype_list?type=Expense');

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> liability_icon_list = [];
      for (var i = 0; i < json.decode(response.body)["Expense"].length; i++) {
        liability_icon_list
            .add(jsonEncode(json.decode(response.body)["Expense"][i]));
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
  var subtype;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profiles()));
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
                      } else {
                        row = icon_name;
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
                                                  SecondScreen(
                                                      type: 'Expense',
                                                      subtypeCode: subtypescode,
                                                      subtypeName:
                                                          subtypesname)),
                                        );
                                      },
                                      label: Text(
                                        _textEditingController.text.isNotEmpty
                                            ? jsonDecode(row[index])[0]
                                            : jsonDecode(row[index])[0],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            letterSpacing: .7),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => customExpense()),
              );
            }));
  }
}
