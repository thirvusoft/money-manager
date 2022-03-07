import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Categories/Expense.dart';

class expenseSearch extends StatefulWidget {
  const expenseSearch({Key? key}) : super(key: key);

  @override
  _expenseSearchState createState() => _expenseSearchState();
}

class _expenseSearchState extends State<expenseSearch> {
  TextEditingController _textEditingController = TextEditingController();
  List icon_nameOnSearch = [];
  List icon_name = [
    ['Food', 0xf2e9],
    ['Travel', 0xf172],
    ['Grocery', 0xf37d],
    ['Entertainment', 0xf3cf],
    ['Shopping', 0xf37f],
    ['Clothing', 984383],
    ['Insurance', 0xf05f0],
    ['Tax', 0xf24e],
    ['Gas', 0xf076],
    ['Electricity', 0xf016],
    ['Telephone', 0xf28c],
    ['Recharge', 0xf28d],
    ['Health', 0xf0f2],
    ['Beauty', 0xf041],
    ['Electronics', 0xef0d],
    ['Gift', 986692],
    ['Education', 0xf33c],
    ['Maintenance', 0xf108],
    ['Social service', 0xf06a4],
    ['Construction', 0xf109],
    ['Crop', 0xf041],
    ['Fertilizer', 0xf068b],
  ];

  var data;
  get index => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12),
            itemCount: _textEditingController.text.isNotEmpty
                ? icon_nameOnSearch.length
                : icon_name.length,
            itemBuilder: (context, index) {
              print(icon_name[index][1]);
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
                        _textEditingController.text.isNotEmpty
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add, semanticLabel: 'Customise icon'),
            backgroundColor: Color.fromARGB(255, 93, 99, 216),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => customExpense()),
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
                  //submit();
                })
          ]),
    ),
  );
}
