import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/views/screens/Categories/liability.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Categories/Asset.dart';
import 'package:http/http.dart' as http;

import '../profile.dart';

class liabilitySearch extends StatefulWidget {
  const liabilitySearch({Key? key}) : super(key: key);

  @override
  _liabilitySearchState createState() => _liabilitySearchState();
}

class _liabilitySearchState extends State<liabilitySearch> {
  var file;
  File _myImage = File('');
  pickImage(ImageSource source) async {
    XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 100,
      maxHeight: MediaQuery.of(context).size.height,
      maxWidth: MediaQuery.of(context).size.width,
      preferredCameraDevice: CameraDevice.rear,
    );
    setState(() {
      print(_myImage);
      if (image == null) {
        //TODO: Image not selected action.
        isFileSelected = 0;
      } else {
        //TODO: Image selected action.
        _myImage = File(image.path);
        bool isLoading = true;
        final bytes = Io.File(image.path).readAsBytesSync();

        String img64 = base64Encode(bytes);
        print(img64);
        uploadimage(_myImage);

        isFileSelected = 1;
      }
    });
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
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();

  bool _loading = true;
  List icon_nameOnSearch = [];
  List icon_name = [];
  var hexcode_dict = <String, int>{
    ' 0xf2d1': 0xf2d1,
    ' 0xeea2': 0xeea2,
    '0xe13c': 0xe13c,
    '0xf0de': 0xf0de,
    '0xf05ff': 0xf05ff,
  };

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
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

  Future listapi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    var response = await http.post(
        Uri.parse(
            "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.withsubtype?Type=Liability"),
        headers: {"Authorization": prefs.getString('token') ?? ""});
    print(response.statusCode);
    print('status API');

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> liability_icon_list = [];
      for (var i = 0; i < json.decode(response.body)["Liability"].length; i++) {
        liability_icon_list
            .add(jsonEncode(json.decode(response.body)["Liability"][i]));
      }
      prefs.setStringList('liability_icon_list', liability_icon_list);
      icon_name = prefs.getStringList("liability_icon_list")!;
      setState(() => _loading = true);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(json.decode(response.body)['message']),
      //   backgroundColor: Colors.green,
      // ));
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
  var subtypes;
  get index => null;
  @override
  Widget build(BuildContext context) {
    var file;

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
                    data = jsonDecode(icon_name[i])[0];
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
                                        subtypes = jsonDecode(row[index])[0];
                                        _show(context, subtypes);
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
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("Liability",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25)),
                      ),
                      Text(subtypes, style: TextStyle(fontSize: 20)),
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
                          decoration:
                              InputDecoration(labelText: 'Reminder Date'),
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
                                        primary: Colors.red,
                                        surface: Colors.red)),
                                child: child,
                              );
                            };
                            dateController.text =
                                date.toString().substring(0, 10);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the date";
                            } else {
                              return null;
                            }
                          }),
                      TextButton(
                          onPressed: () {
                            _onAlertWithCustomContentPressed;
                          },
                          child: Text(
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
                            print('yyyyyyyyyyyyyyyy');
                            if (formKey.currentState!.validate()) {
                              dataentry(
                                typecontroller.text,
                                subtypes,
                                namecontroller.text,
                                notescontroller.text,
                                amountcontroller.text,
                                datecontroller.text,
                              );
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

  Future dataentry(
    type,
    subtypes,
    name,
    notes,
    amount,
    date,
  ) async {
    if (typecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty ||
        datecontroller.text.isNotEmpty) {
      print(subtypecontroller.text);
      print(dotenv.env['API_URL']);

      var response = await http.post(Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Liability&Subtype=${subtypes}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}"));
      //print(response.statusCode);
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
    print("test11");
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
            pickImage(ImageSource.camera);
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
          print(img64);
          Navigator.pop(
            context,
          );
        },
      )
    ]).show();
  }

  Future uploadfile(File img64) async {
    var bytes = img64.readAsBytesSync();
    print(bytes);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));

    var response = await http.post(
      Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.upload_profile_image"),
      headers: {"Authorization": prefs.getString('token') ?? ""},
      body: {"file", bytes},
      encoding: Encoding.getByName("utf-8"),
    );
    return response.body;
  }

  Future uploadimage(_myimage) async {
    var bytes = _myimage.readAsBytesSync();
    String imgcontent = base64Encode(bytes);
    print(bytes);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));

    var response = await http.post(
      Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.upload_profile_image"),
      headers: {"Authorization": prefs.getString('token') ?? ""},
      body: {imgcontent},
      // encoding: Encoding.getByName("utf-8"),
    );
    print(response.statusCode);
    print('test api');
    return response.body;
  }
}
