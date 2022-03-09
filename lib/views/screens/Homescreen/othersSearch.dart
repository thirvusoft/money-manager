import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Categories/Asset.dart';
import 'package:http/http.dart' as http;

import '../Categories/Others.dart';

class othersSearch extends StatefulWidget {
  const othersSearch({Key? key}) : super(key: key);

  @override
  _othersSearchState createState() => _othersSearchState();
}

class _othersSearchState extends State<othersSearch> {
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
    ['Invitation', 0xf12f],
    ['Visiting Card', 0xef8f],
    ['Profile', 0xee35],
  ];
  var data;
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
                                        _show(context);
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
                MaterialPageRoute(builder: (context) => customOthers()),
              );
            }));
  }

  void _show(BuildContext ctx) {
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
              Text("Others",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

              TextField(
                controller: subtypecontroller,
                decoration: InputDecoration(labelText: 'SubType'),
              ),
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
                        subtypecontroller.text,
                        namecontroller.text,
                        notescontroller.text,
                        amountcontroller.text,
                        datecontroller.text);
                  })
            ]),
      ),
    );
  }

  Future dataentry(type, subtype, name, notes, amount, date) async {
    if (typecontroller.text.isNotEmpty ||
        subtypecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty ||
        datecontroller.text.isNotEmpty) {
      print(subtypecontroller.text);
      var response = await http.post(Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Others&Subtype=${subtype}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}"));
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
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
