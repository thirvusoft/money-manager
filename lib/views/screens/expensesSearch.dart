import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    ['Mobile Recharge', 0xf28d],
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
        title: Container(
          decoration: BoxDecoration(
              color: Colors.blue.shade200,
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
                    print(icon_nameOnSearch);
                  }
                }
              });
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.search_off_outlined),
                onPressed: () {},
              ),
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
          itemCount: _textEditingController!.text.isNotEmpty
              ? icon_nameOnSearch.length
              : icon_name.length,
          itemBuilder: (context, index) {
            print(icon_name[index][1]);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(IconData(icon_name[index][1],
                        fontFamily: 'MaterialIcons')),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(_textEditingController!.text.isNotEmpty
                      ? icon_nameOnSearch[index][0]
                      : icon_name[index][0]),
                ],
              ),
            );
          }),
    );
  }
}
