import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class customAsset extends StatefulWidget {
  const customAsset({Key? key}) : super(key: key);

  @override
  _customAssetState createState() => _customAssetState();
}

class _customAssetState extends State<customAsset> {
  TextEditingController _textEditingController = TextEditingController();
  var typecontroller = TextEditingController();
  var namecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var code;
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
  @override
  void initState() {
    super.initState();
    listapi();
  }

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
    }
  }

  var data;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 99, 216),
        title: Text('Asset Customise Icons'),
      ),
      body: Container(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12),
            itemCount: _textEditingController.text.isNotEmpty
                ? icon_nameOnSearch.length
                : icon_name.length,
            itemBuilder: (context, index) {
              code = icon_name[index][1];
              print(icon_name[index][1]);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundColor: Color.fromARGB(255, 93, 99, 216),
                      child: IconButton(
                          iconSize: 30.0,
                          onPressed: () {
                            _show(context);
                          },
                          icon: Icon(
                              IconData(
                                jsonDecode(icon_name[index])[1],
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Color.fromARGB(255, 255, 255, 255))),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
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
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "Asset",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: 'Name:'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the name";
                            } else {
                              return null;
                            }
                          }),
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
                            if (formKey.currentState!.validate()) {
                              cussubmit(
                                typecontroller.text,
                                namecontroller.text,
                                code,
                              );
                            }
                          })
                    ]),
              ),
            ));
  }

  Future cussubmit(type, name, code) async {
    if (namecontroller.text.isNotEmpty) {
      var response = await http.post(Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.custom?Type=Asset&Subtype=${name}&IconBineryCode=${code}"));
      print(namecontroller.text);
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Submitted Successfully"),
          backgroundColor: Colors.green,
        ));
      } else {
        print(response.statusCode);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Try again"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
