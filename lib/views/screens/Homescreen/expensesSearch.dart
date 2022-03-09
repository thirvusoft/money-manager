import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Categories/Asset.dart';
import 'package:http/http.dart' as http;

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
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Color.fromARGB(255, 93, 99, 216);
      setState(() {
        _loading = false;
      });
    });
  }

  List icon_nameOnSearch = [];
  List icon_name = [
    ['Food', 0xf2e9],
    ['Travel', 0xf172],
    ['Grocery', 0xf37d],
    ['Entertainment', 0xf3cf],
    ['Shopping', 0xf37f],
    ['Clothing', 984383],
    ['Insurance', 0xf05f0],
    ['Tax', 0xf24e],
    ['Gas', 0xf076],
    ['Electricity', 0xf016],
    ['Telephone', 0xf28c],
    ['Recharge', 0xf28d],
    ['Health', 0xf0f2],
    ['Beauty', 0xf041],
    ['Electronics', 0xef0d],
    ['Gift', 986692],
    ['Education', 0xf33c],
    ['Maintenance', 0xf108],
    ['Social service', 0xf06a4],
    ['Construction', 0xf109],
    ['Crop', 0xf041],
    ['Fertilizer', 0xf068b],
  ];

  var data;
  var subtype;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                hintText: "search",
              ),
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
                                        subtype = icon_name[index][0];
                                        _show(context, subtype);
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
                                          IconData(icon_name[index][1],
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
                MaterialPageRoute(builder: (context) => customAsset()),
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
              Align(
                alignment: Alignment
                    .center, // Align however you like (i.e .centerRight, centerLeft)
                child: Text("Expense",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              ),

              Text(subtype,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              // TextField(
              //   controller: subtypecontroller,
              //   decoration: InputDecoration(labelText: 'SubType'),
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
              // TextButton(
              //   style: TextButton.styleFrom(
              //     textStyle: const TextStyle(fontSize: 20),
              //   ),
              //   onPressed: () {},
              //   child: const Text('Image'),
              // ),
              // Divider(),
              // TextButton(
              //   style: TextButton.styleFrom(
              //     textStyle: const TextStyle(fontSize: 20),
              //   ),
              //   onPressed: () {},
              //   child: const Text('File',
              //       style: TextStyle(color: Colors.blueAccent)),
              // ),
              // Divider(),

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
                        datecontroller.text);
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
      print(subtypecontroller.text);
      var response = await http.post(Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Expense&Subtype=${subtypes}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}"));
      //print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("submited sucessfully"),
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
}
