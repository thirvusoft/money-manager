import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:money_manager/views/screens/Categories/liability.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class searchbar extends StatefulWidget {
  const searchbar({Key? key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  var result;
  File _myImage = File('');

  get defaultText => null;

  get linkText => null;

  get imgcontent => null;

  pickImage(ImageSource source) async {
    XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 100,
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (image == null) {
      //TODO: Image not selected action.
      isFileSelected = 0;
    } else {
      //TODO: Image selected action.
      _myImage = File(image.path);
      bool isLoading = true;
      final bytes = Io.File(image.path).readAsBytesSync();

      String imgcontent = base64Encode(bytes);

      isFileSelected = 1;
    }
  }

  Widget showImage(File file) {
    if (isFileSelected == 0) {
      //TODO: Image not selected widget.
      return Center(child: Text("Image Selected"));
    } else {
      //TODO: Image selected widget.
      return Container(
        height: MediaQuery.of(context).size.width * 9 / 16,
        width: MediaQuery.of(context).size.width,
        child: Image.file(file, fit: BoxFit.contain),
      );
    }
    // ignore: dead_code
  }

  int isFileSelected = 0;
  ImagePicker picker = ImagePicker();
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

  bool _loading = false;
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
                uploadimage();
                print("eyrtr");
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
                    data = icon_name[i][0];

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
                                        _show(context, subtypescode,
                                            subtypesname);
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
              _loading = false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => customAsset()),
              );
            }));
  }

  void _show(BuildContext ctx, subtypescode, subtypesname) {
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
                      Align(
                        alignment: Alignment.center,
                        child: Text("Asset",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25)),
                      ),
                      Text(subtypesname, style: TextStyle(fontSize: 20)),
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
                      TextButton(
                          onPressed: () {
                            _onAlertWithCustomContentPressed(context);
                          },
                          child: const Text(
                            "Upload",
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          )),
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
                          })
                    ]),
              ),
            ));
  }

  Future dataentry(type, subtypescode, name, notes, amount) async {
    if (typecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty) {
      // var response = await http.post(Uri.parse(
      //      dotenv.env['API_KEY'] ?? ""));
      // var response = await http.post(Uri.parse(
      //     '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Asset&Subtype=${subtypes}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}'),
      //     headers: {}
      //     );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.post(
          Uri.parse(
              '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Asset&Subtype=${subtypescode}&Name=${name}&Notes=${notes}&Amount=${amount}'),
          headers: {"Authorization": prefs.getString('token') ?? ""});
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
      } else if (response.statusCode == 4) {
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

  _onAlertWithCustomContentPressed(context) {
    var alertStyle = AlertStyle(
      isCloseButton: false,
      isOverlayTapDismiss: true,
    );
    Alert(context: context, title: "Image", buttons: [
      DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
            "Camera",
            style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          }),
      DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
            "Image",
            style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
          ),
          onPressed: () {
            pickImage(ImageSource.gallery);

            Navigator.pop(
              context,
            );
          }),
      DialogButton(
        color: Color.fromARGB(255, 93, 99, 216),
        child: Text(
          "Image",
          style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
        ),
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles();
          if (result == null) return;
          var img;
          img = result.files.first;

          final bytes = Io.File(img.path).readAsBytesSync();

          String img64 = base64Encode(bytes);
          Navigator.pop(
            context,
          );
        },
      )
    ]).show();
  }

  // Future uploadfile(File img64) async {
  // var bytes = img64.readAsBytesSync();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   var response = await http.post(
  //     Uri.parse(
  //         "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.upload_profile_image"),
  //     headers: {"Authorization": prefs.getString('token') ?? ""},
  //     body: {"file", bytes},
  //     encoding: Encoding.getByName("utf-8"),
  //   );
  //   return response.body;
  // }

  Future uploadimage() async {
    print("ryyrg");
    var bytes =
        "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VXGeo+rRI6R5eZZCc+2/eVzPpnwzJ9jzehJVEwJ8HmXa/Ovzvt86+adN5559yNQ6jUkoEog5R0ydEXo+l69sx8XpIi1RYLWZqltK3UvLelfL0s6hpG6fLPm7T833Gh/d9HsPZVVGPION7luWort0cvobToW47qYPhbL8RNY6BynqyhQIiYhCagEBQS4AAFqosAKAmJKAALSAAJAABIACSEiJCJAAAKACAoFAAAAAJiACBNqQl1RZUSgSgTAACCUSAImAASASgSiQC1VioETBCRAEBUAAESEAFTxe0tBAgCAImtAAXEACxVYAJiQAKAAWIAEgAACYkATASAAAAUCgAAAACqWVFlEWgAAAAExIAAATAAAABCRCQAAmBJBIAAAITAiYIBUAAAEAVsqqwVIAAgEJioABctFbAASISAAAFgAAEkAkACYCYEgAATEgAUACgCElWC0RWLVCx4D3seQSAAABMAkiYEgkETAkEAAAAAAAAAAAlAmYACJVAiIkUWrQQAIAoIFaBQkEACAgUBexAAkAAAAFgABMSAACph9HJOtiQAhIAJEJAUCgEQloqgAAABy/qHLjePs/G+0AAAASAB5vTyE68mBMASAESQkAQAAAABEgQSiQgTNZEwJBMRJCRWmatY14iq1QBEiEwK2rQKEggAhMUiYUC69koITEgUCggC1bQAmJABy06k83pFb0OTdc5H1xQQkESRKCQAERVlETFRYAAAkiQAcb2v5q9A9YgAAEokAAch69yFevJhABIAAAAgBJAAAAITAAAmBZUIVoImazVpxoyKi8UFqpIplgxzcUrkrVQABCJgRMUiYUEvMIsBMSBQAKLIASgAByzqfLF6T6/J60UvQ5N1zkfXFJIAAIJiomJEVtUWASQsKpkiZkrMyVABiyhCREWgJERIAAAch69yFevJhCwrIAACSEwQkAAQSQkQQTAAAItFQBWwCAAAFbVAABAia1M1LaogQIJgCBCRawEiJmAmBatgmASRIAACRyvqnK1pk6V6TVNovROTbPy7d5fl+/qiuTfT6Lqhtccw6eg+KZufebrS8yxdXHId9+/wAJO7vD9BObua92XScPWRz3oHm9SR8/Hy1fpW6X6DlPn68NY2jh3WD7IQBzbpXGl9mHro8Hv83qSEiEwAORde5AvUOW+brhzW3VhyLpfr42dreX1IxOOL9ry7/9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";

    var decodedBytes = base64Decode(bytes);
    var change = base64.encode(decodedBytes);
    print(decodedBytes);
    print(change);
    //  print(Uint8List base64Decode(String source) => base64.decode(change));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(
      Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.upload_profile_image"),
      headers: {"Authorization": prefs.getString('token') ?? ""},
      body: {"file": bytes},
      encoding: Encoding.getByName("utf-8"),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("rgt");
    }
    return response.body;
  }
}
