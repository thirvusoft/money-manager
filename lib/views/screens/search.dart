import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    ['Home Appliance', 0xf447],
    ['Machinery', 0xef06],
    ['Agri Land', 987215],
    ['Comm Land', 0xf42b],
    ['Residential Land', 98633],
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
            controller: _textEditingController,
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
              );
            }),
      ),
    );
  }
}
