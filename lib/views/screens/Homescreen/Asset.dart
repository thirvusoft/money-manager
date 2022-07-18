import 'dart:convert';
import 'package:sizer/sizer.dart';
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
  bool mobile(BuildContext context) => MediaQuery.of(context).size.width < 300;
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
  var code;
  final formKey = GlobalKey<FormState>();

  bool _loading = true;
  List icon_nameOnSearch = [];
  List icon_name = [];
  var hexcode_dict = <String, int>{
    '0xf1dd': 0xf1dd,
    '0xf1dd': 0xf1dd,
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

  Future listapi() async {
    _loading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await http.post(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.subtype_list?type=Asset"),
        headers: {"Authorization": prefs.getString('token') ?? ""});

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> liability_icon_list = [];

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
    return Sizer(builder: (context, orientation, deviceType) {
      double screenwidth = MediaQuery.of(context).size.width;
      double screenheight = MediaQuery.of(context).size.height;
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
                          crossAxisCount: screenwidth >= 360 ? 2 : 1,
                          childAspectRatio: screenwidth >= 360 ? 3 : 5,
                          crossAxisSpacing: screenwidth >= 400 ? 50 : 15),
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 25,
                                ),
                                InkWell(
                                  onTap: () {
                                    subtypescode = jsonDecode(row[index])[2];
                                    subtypesname = jsonDecode(row[index])[0];

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SecondScreen(
                                              type: 'Asset',
                                              subtypeCode: subtypescode,
                                              subtypeName: subtypesname)),
                                    );
                                  },
                                  child: CircleAvatar(
                                      child: Text(
                                        jsonDecode(row[index])[3],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      backgroundColor:
                                          Color.fromARGB(255, 93, 99, 216)),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 15,
                                ),
                                TextButton(
                                  onPressed: () {
                                    subtypescode = jsonDecode(row[index])[2];
                                    subtypesname = jsonDecode(row[index])[0];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SecondScreen(
                                              type: 'Asset',
                                              subtypeCode: subtypescode,
                                              subtypeName: subtypesname)),
                                    );
                                  },
                                  child: Text(
                                    _textEditingController.text.isNotEmpty
                                        ? jsonDecode(row[index])[0]
                                        : jsonDecode(row[index])[0],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenwidth / 25,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )
                              ],
                            ));
                      })),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add, semanticLabel: 'Customise icon'),
              backgroundColor: Color.fromARGB(255, 93, 99, 216),
              onPressed: () {
                _show(context);

                _loading = false;
              }));
    });
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
                          maxLength: 11,
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
                              namecontroller.clear();
                            }
                          })
                    ]),
              ),
            ));
  }

//DataEntry API
  Future cussubmit(type, name, code) async {
    _loading = false;
    if (namecontroller.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.post(
          Uri.parse(
              "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.create_new_subtype?type=Asset&subtype=${name}&iconbinerycode=${code}"),
          headers: {"Authorization": prefs.getString('token') ?? ""});

      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Submitted Successfully"),
          backgroundColor: Colors.green,
        ));
      } else if (response.statusCode == 401) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
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
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 500) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 503) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 409) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 404) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
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
}
