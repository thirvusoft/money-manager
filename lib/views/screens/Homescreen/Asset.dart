// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money_manager/views/screens/Categories/liability.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Categories/Asset.dart';
import 'package:http/http.dart' as http;

import '../profile.dart';

// var item_name;
// var decode;

class searchbar extends StatefulWidget {
  const searchbar({Key? key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  TextEditingController _textEditingController = TextEditingController();

  var typecontroller = TextEditingController();
  var subtypecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var notescontroller = TextEditingController();
  var amountcontroller = TextEditingController();
  var datecontroller = TextEditingController();

  bool _loading = true;

  List icon_nameOnSearch = [];
  List icon_name = [];

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

  // @override
  // void dispose() {
  //   super.dispose();
  // }
  Future listapi() async {
    var response = await http.post(Uri.parse(
        "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.withsubtype?Type=Asset"));
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> liability_icon_list = [];
      for (var i = 0; i < json.decode(response.body)["Asset"].length; i++) {
        liability_icon_list
            .add(jsonEncode(json.decode(response.body)["Asset"][i]));
      }
      prefs.setStringList('liability_icon_list', liability_icon_list);
      icon_name = prefs.getStringList("liability_icon_list")!;
      print(icon_name);
      setState(() => _loading = true);
    }
  }

  var data;
  var subtypes;
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
            width: 330,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  value.trimLeft();
                  icon_nameOnSearch.clear();
                  for (var i = 0; i < icon_name.length; i++) {
                    data = icon_name[i][0];
                    if (data
                        .toLowerCase()
                        .contains(value.trim().toLowerCase())) {
                      icon_nameOnSearch.add(icon_name[i]);
                      print(icon_nameOnSearch);
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
                      print(icon_name[index][1]);
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Center(
                                  child: TextButton.icon(
                                      onPressed: () {
                                        subtypes = icon_name[index][0];
                                        _show(context, subtypes);
                                        print(icon_name[index][0]);
                                      },
                                      label: Text(
                                        _textEditingController.text.isNotEmpty
                                            ? icon_nameOnSearch[index][0]
                                            : icon_name[index][0],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            letterSpacing: .7),
                                      ),
                                      icon: Icon(
                                          IconData(int.parse(
                                              jsonDecode(icon_name[index])[1])),
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
                MaterialPageRoute(builder: (context) => customLiability()),
              );
            }));
  }

  void _show(BuildContext ctx, subtypes) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      elevation: 5,
      context: ctx,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField(
              //   controller: subtypecontroller,
              //   decoration: InputDecoration(labelText: 'SubType'),
              // ),
              Align(
                alignment: Alignment
                    .center, // Align however you like (i.e .centerRight, centerLeft)
                child: Text("Liability",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25)),
              ),
              Text(subtypes, style: TextStyle(fontSize: 20)),
              // TextField(
              //   controller: subtypecontroller,
              //   decoration: InputDecoration(labelText: 'Subtype'),
              // ),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(labelText: 'Name'),
              ),

              TextField(
                controller: notescontroller,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              TextField(
                controller: amountcontroller,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              TextField(
                controller: datecontroller,
                decoration: InputDecoration(labelText: 'Remainder date'),
              ),

              SizedBox(
                height: 15,
              ),
              RaisedButton(
                  color: Color.fromARGB(255, 93, 99, 216),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // print(typecontroller.text);
                    dataentry(
                      typecontroller.text,
                      subtypes,
                      namecontroller.text,
                      notescontroller.text,
                      amountcontroller.text,
                      datecontroller.text,
                    );
                  })
            ]),
      ),
    );
  }

  Future dataentry(type, subtypes, name, notes, amount, date) async {
    if (typecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty ||
        datecontroller.text.isNotEmpty) {
      print("check");
      var response = await http.post(Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Liability&Subtype=${subtypes}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}"));
      print(response.statusCode);
      print("response");
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Submited Sucessfully"),
          backgroundColor: Colors.green,
        ));
      } else {
        print(response.statusCode);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  // Future listapi() async {
  //   print('profile');
  //   var response = await http.post(Uri.parse(
  //       "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.withsubtype?Type=Asset"));
  //   // print(response);
  //   if (response.statusCode == 200) {
  //     print(response.statusCode);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //     // item_name = json.decode(response.body)["Asset"];
  //     // decode = prefs.getStringList(json.encode(response.body));
  //     //print(decode);
  //     // print(prefs.get); // to print json data
  //     // List list2 = json.decode(response.body)["Asset"];
  //     // print(list2);

  //     List<dynamic> list1 = jsonDecode(prefs.getString("Asset").toString());

  //     // final item = list1[0];
  //     // print(item[1](0));

  //   }
  // }
}

// var usersDataFromJson = parsedJson['Asset'];
// List<String> Asset = List<String>.from(usersDataFromJson);
// print(Asset);
// final List<String> decode =
//     prefs.getStringList(response.body)["Asset"];
//var decode = prefs.setString( "Asset", json.decode(response.body).cast<String, dynamic>());
// // print(prefs.setStringList(type', json.decode(response.body)["ts_subtype, icon_code"]));
// print(item['ts_subtype']); // foo
// print(item['icon_code']); // 1
//print(item['s']); // f
// var store = prefs.setStringList("Asset", json.decode(response.body));
// var sdf = prefs.setStringList( "Asset", json.decode(response.body)['Asset[1]'] ?? [].toList());
// print(sdf);
//print(decode);
//prefs.setStringList("icon_code");
//prefs.getStringList("ts_subtype") ?? [];
//prefs.getStringList("icon_code") ?? ["Asset"];
//prefs.setStringList("icon_code", json.decode(response.body)['Asset[0]']);
//print(prefs.getString("icon_code"));
// print(store);
//prefs.setStringList("ts_subtype", json.decode(response.body)['Asset']['ts_subtype']);
