import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../widgets/submitapi.dart';

class searchbar extends StatefulWidget {
  const searchbar({Key? key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  TextEditingController textEditingController = TextEditingController();
  List icon_nameOnSearch = [];
  List icon_name = [
<<<<<<< HEAD
    [
      'Home Appliances',
    ],
    ['Machinery', 61190],
    ['Agri Land', 0xf106d],
    ['Commercial Land', 0xef0b],
    ['Residential Land', 0xf19c1],
    ['money', 0xf37f]
=======
    ['Gold', 987727],
    ['Silver', 987727],
    ['Platinum', 987727],
    ['Diamond', 0xf05e7],
    ['Vehicles', 0xee62],
    ['Home Appliance', 0xf447],
    ['Machinery', 0xef06],
    ['Agri Land', 987215],
    ['Comm Land', 0xf42b],
    ['Residential Land', 98633],
>>>>>>> deaccda462085423687eb78c84c6ba9a64de6a5d
  ];

  var data;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 93, 99, 216),
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
                  if (data.toLowerCase().contains(value.trim().toLowerCase())) {
                    icon_nameOnSearch.add(icon_name[i]);
                  }
                }
              });
            },
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              hintText: "Search",
            ),
          ),
        ),
      ),
<<<<<<< HEAD
      body: textEditingController.text.isNotEmpty && icon_name.length == 0
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
=======
      body: Container(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12),
            itemCount: _textEditingController!.text.isNotEmpty
                ? icon_nameOnSearch.length
                : icon_name.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
>>>>>>> deaccda462085423687eb78c84c6ba9a64de6a5d
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 93, 99, 216),
                      child: Icon(
                        IconData(icon_name[index][1],
                            fontFamily: 'MaterialIcons'),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                        _textEditingController!.text.isNotEmpty
                            ? icon_nameOnSearch[index][0]
                            : icon_name[index][0],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            letterSpacing: .7)),
                  ],
                ),
<<<<<<< HEAD
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12),
              itemCount: textEditingController.text.isNotEmpty
                  ? icon_nameOnSearch.length
                  : icon_name.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        // child: IconButton(
                        //     onPressed: () {}, icon: Icon(IconData(icon_name[index][1],fontFamily: 'MaterialIcons')),

                        child: IconButton(
                            onPressed: () {
                              _show(context);
                            },
                            icon: Icon(IconData(icon_name[index][1],
                                fontFamily: 'MaterialIcons'))),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(textEditingController.text.isNotEmpty
                          ? icon_nameOnSearch[index][0]
                          : icon_name[index][0]),
                    ],
                  ),
                );
              }),
=======
              );
            }),
      ),
>>>>>>> deaccda462085423687eb78c84c6ba9a64de6a5d
    );
  }
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
            // ignore: prefer_const_constructors
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Image'),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Notes'),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text("Submit"),
                onPressed: () {
                  submit();
                })
            // text: 'SUBMIT',
            // color: Color.fromARGB(255, 197, 105, 14),
            // pressEvent: () {
            //   AwesomeDialog(
            //     context: ctx,
            //     dialogType: DialogType.SUCCES,

            //     //headerAnimationLoop: false,
            //     // animType: AnimType.TOPSLIDE,
            //     // showCloseIcon: true,
            //     // closeIcon: Icon(Icons.close_fullscreen_outlined),
            //     title: 'Submit Successfully',
            //     btnOkOnPress: () {
            //       Navigator.pop(ctx);
            //     },
            //   )..show();

            //       Navigator.pop(ctx);
            //     })
            // AnimatedButton(
            //   text: 'SUBMIT',
            //   color: Colors.blue,
            //   onPressed: () {
            //     // ignore: missing_required_param
            //     AwesomeDialog(
            //       dialogType: DialogType.WARNING,
            //       headerAnimationLoop: false,
            //       animType: AnimType.TOPSLIDE,
            //       showCloseIcon: true,
            //       closeIcon: Icon(Icons.close_fullscreen_outlined),
            //       title: 'SUBMIT',
            //       desc: 'Dialog description here',
            //       btnCancelOnPress: () {},
            //       btnOkOnPress: () {},
            //     )..show();
          ]),
    ),
  );
}
