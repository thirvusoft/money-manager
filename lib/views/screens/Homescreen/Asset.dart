// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'dart:io'as Io;
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
import 'dart:io'as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


// class Environment{
//   static String get fileName {
    
//     return '.env';
//   }
//   static String get apiUrl{
//     return dotenv.env['API_URL'] ?? 'API_URL not found';
//   }
// }

class searchbar extends StatefulWidget {
  const searchbar({Key? key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  var result;
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
        print(_myImage);

        isFileSelected = 1;
      }
    }
    );
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
    ['Gold', 0xf1dd],
    ['Silver', 0xf1dd],
    ['Platinum', 0xf1dd],
    ['Vehicles', 0xee62],
    ['Home ', 0xe45f],
    ['Machinery', 0xef06],
    ['Comm Land', 0xf42b],
    ['Residential ', 0xf1af],
  ];
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
                                    
                                    style: TextButton.styleFrom(
                                    ),
                                    
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
                                          IconData(icon_name[index][1],
                                              fontFamily: 'MaterialIcons'),
                                          color: Color.fromARGB(
                                              255, 93, 99, 216)))),
                            ],
                          ));
                    }),),
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
                      TextField(
                        controller: notescontroller,
                        decoration: InputDecoration(labelText: 'Notes'),
                      ),
                      TextField(
                        controller: amountcontroller,
                        decoration: InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                      ),
                      
               
               TextButton(
              
                 onPressed: () async {_onAlertWithCustomContentPressed(context);},
                child: const Text('Upload',
                     style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
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
                            if (formKey.currentState!.validate()) {
                              // print(typecontroller.text);

                              dataentry(
                                typecontroller.text,
                                subtypes,
                                namecontroller.text,
                                notescontroller.text,
                                amountcontroller.text,
                                datecontroller.text,
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
     
      // var response = await http.post(Uri.parse(
      //      dotenv.env['API_KEY'] ?? ""));
      var response = await http.post(Uri.parse(
      '${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Asset&Subtype=${subtypes}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}'
       ));
      //print(response.statusCode);
      print(name);
      if (response.statusCode == 200) {
        print(response.statusCode);
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Submited sucessfully"),
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
    _onAlertWithCustomContentPressed(context){
      var alertStyle=AlertStyle(
         isCloseButton: false,
         isOverlayTapDismiss: true,);
    Alert(context: context,
    title: "Image",
      buttons: [
        
        DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
          "Camera",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
        ), onPressed: ()=>pickImage(ImageSource.camera),
        ),
        DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
          "Image",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
        ), onPressed: ()=>pickImage(ImageSource.gallery),
        ),
       DialogButton(
          color: Color.fromARGB(255, 93, 99, 216),
          child: Text(
          "Image",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
        ), onPressed: () async{
     


print("object");
              final result = await FilePicker.platform.pickFiles();
             if(result == null)
         
              return;
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
  Future uploadimage(File img64) async {
    var bytes = img64.readAsBytesSync();
    print(bytes);

    var response = await http.post(
      Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.upload_profile_image"),
      
     // headers: {"Authorization",token f2438cbb8b260d5:8484dfdb326fe79},
      body: {"file", bytes},
      encoding: Encoding.getByName("utf-8"),
    );
    return response.body;
  }

   

  
   





}


