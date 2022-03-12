import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_manager/views/screens/Categories/Others.dart';
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
        var file;

    return Scaffold(
        appBar: AppBar(
          actions: [ InkWell( onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Profiles()));
        }, 
                 child: Padding( 
                        padding: const EdgeInsets.all(8.0),
                        child: Icon( Icons.account_circle_outlined, size: 30,), 
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
                hintText: "search",
                prefixIcon: Icon(Icons.search,
                color: Color.fromARGB(
                                              255, 93, 99, 216),)

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
        child: SingleChildScrollView(
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
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () => _onAlertWithCustomContentPressed(context),
                //pickImage(ImageSource.camera),
                child: const Text('Upload',                              
                style: TextStyle(
                                  color: Color.fromARGB(255, 54, 54, 58),
                                  fontSize: 15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                                  
                                  ),
              ),
              //Divider(),
              //  TextButton(
              //   style: TextButton.styleFrom(
              //     textStyle: const TextStyle(fontSize: 20),
              //   ),
              //   onPressed: () => pickImage(ImageSource.gallery),
              //   child: const Text('Image',style: TextStyle(
              //                     color: Color.fromARGB(255, 54, 54, 58),
              //                     fontSize: 15,
              //                     fontFamily: "Roboto",
              //                     fontWeight: FontWeight.bold),),
              // ),
              // Divider(),
              // TextButton(
              //   style: TextButton.styleFrom(
              //     textStyle: const TextStyle(fontSize: 20),
              //   ),
              //   onPressed: () {
              //     pickFiles();
              //   },
                
              //   child: const Text('File',style: TextStyle(
              //                     color: Color.fromARGB(255, 54, 54, 58),
              //                     fontSize: 15,
              //                     fontFamily: "Roboto",
              //                     fontWeight: FontWeight.bold),
              //       ),
                    
              // ),
              (file == null)? Container():Image.file(File(file!.path.toString()),),
            
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
            print(dotenv.env['API_URL']);

      var response = await http.post(Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Others&Subtype=${subtype}&Name=${name}&Notes=${notes}&Amount=${amount}&Remainder_date=${date}"));
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
          "File",
                    style: TextStyle(color: Color.fromARGB(255, 255, 253, 253)),
        ), onPressed: (){pickFiles();},
        ),
      
      ],
    
 
    ).show();
  }
}
void pickFiles() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,allowedExtensions: 
    ['pdf','doc'],
  );
  if(result == null)
  return;

  var file = result.files.first;
  viewFile(file);
}

void viewFile(PlatformFile file) {

  var OpenFile;
  OpenFile.open(file.path);
  print(OpenFile);
}
