import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Categories/Asset.dart';

class searchbar extends StatefulWidget {
  const searchbar({Key? key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  TextEditingController _textEditingController = TextEditingController();
  List icon_nameOnSearch = [];
  List icon_name = [
    ['Gold', 987727],
    ['Silver', 987727],
    ['Platinum', 987727],
    ['Diamond', 0xf05e7],
    ['Vehicles', 0xee62],
    ['Home ', 0xf447],
    ['Machinery', 0xef06],
    ['Agri Land', 987215],
    ['Comm Land', 0xf42b],
    ['Residential ', 98633],
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
                contentPadding: EdgeInsets.all(25),
                hintText: "Search",
              ),
            ),
          ),
        ),
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
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 93, 99, 216),
                        child: IconButton(
                            onPressed: () {
                              _show(context);
                            },
                            icon: Icon(
                                IconData(icon_name[index][1],
                                    fontFamily: 'MaterialIcons'),
                                color: Color.fromARGB(255, 255, 255, 255))),
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
                );
              }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 93, 99, 216),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => customAsset()),
              );
            }));
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
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: const Text('Image'),
            ),
            Divider(),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: const Text('File',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
            Divider(),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Notes'),
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
                  // submit();
                })
          ]),
    ),
  );
}
