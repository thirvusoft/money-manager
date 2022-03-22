import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/views/screens/Categories/Others.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Categories/Asset.dart';
import 'package:http/http.dart' as http;

import '../profile.dart';

class othersSearch extends StatefulWidget {
  const othersSearch({Key? key}) : super(key: key);

  @override
  _othersSearchState createState() => _othersSearchState();
}

class _othersSearchState extends State<othersSearch> {
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
    ' 0xf12f': 0xf12f,
    ' 0xef8f': 0xef8f,
    '0xee35': 0xee35,
    '0xef2d': 0xef2d,
    '0xee33': 0xee33,
    ' 0xf2dd': 0xf2dd,
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
            "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.withsubtype?Type=Others"),
        headers: {"Authorization": prefs.getString('token') ?? ""});
    print(response.statusCode);
    print('status API');

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> liability_icon_list = [];
      for (var i = 0; i < json.decode(response.body)["Others"].length; i++) {
        liability_icon_list
            .add(jsonEncode(json.decode(response.body)["Others"][i]));
      }
      prefs.setStringList('liability_icon_list', liability_icon_list);
      icon_name = prefs.getStringList("liability_icon_list")!;
      setState(() => _loading = true);
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(json.decode(response.body)['message']),
      //   backgroundColor: Colors.red,
      // ));
    } else if (response.statusCode == 401) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
        backgroundColor: Colors.red,
      ));
    } else if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(json.decode(response.body)['message']),
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
                                        subtypes =
                                            jsonDecode(icon_name[index])[0];
                                        _show(context, subtypes);
                                      },
                                      label: Text(
                                        _textEditingController.text.isNotEmpty
                                            ? jsonDecode(icon_name[index])[0]
                                            : jsonDecode(icon_name[index])[0],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            letterSpacing: .7),
                                      ),
                                      icon: Icon(
                                          IconData(
                                              hexcode_dict[jsonDecode(
                                                      icon_name[index])[1]] ??
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
                MaterialPageRoute(builder: (context) => customOthers()),
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
                        alignment: Alignment
                            .center, // Align however you like (i.e .centerRight, centerLeft)
                        child: Text("Others",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
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
                                lastDate: DateTime(2100));
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
                            if (formKey.currentState!.validate()) {
                              // print(typecontroller.text);
                              dataentry(
                                  typecontroller.text,
                                  subtypes,
                                  namecontroller.text,
                                  notescontroller.text,
                                  amountcontroller.text,
                                  datecontroller.text);
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

  Future dataentry(type, subtypes, name, notes, amount, date) async {
    if (typecontroller.text.isNotEmpty ||
        namecontroller.text.isNotEmpty ||
        notescontroller.text.isNotEmpty ||
        amountcontroller.text.isNotEmpty ||
        datecontroller.text.isNotEmpty) {
      print(subtypecontroller.text);
      print(dotenv.env['API_URL']);

      var response = await http.post(Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Others&Subtype=${subtypes}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}"));
      //print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.green,
        ));
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(json.decode(response.body)['message']),
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
        Navigator.pop(context);
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
    Alert(
      context: context,
      title: "Image",
      buttons: [
        DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
            "Camera",
            style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
          ),
          onPressed: () => pickImage(ImageSource.camera),
        ),
        DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
            "Image",
            style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
          ),
          onPressed: () => pickImage(ImageSource.gallery),
        ),
        DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
            "Image",
            style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
          ),
          onPressed: () async {
            print("object");
            final result = await FilePicker.platform.pickFiles();
            if (result == null) return;
            var img;
            img = result.files.first;
            final bytes = Io.File(img.path).readAsBytesSync();

            String img64 = base64Encode(bytes);
            print(img64);

            openFile(img);
          },
        ),
      ],
    ).show();
  }

  void openFile(PlatformFile img) {
    OpenFile.open(img.path!);
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
