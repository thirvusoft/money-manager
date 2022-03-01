import 'package:flutter/material.dart';

class searchbar extends StatefulWidget {
  const searchbar({Key? key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  TextEditingController _textEditingController = TextEditingController();
  List foodListOnSearch = [];
  List foodList = [
    ['Orange', 59191],
    ['apple', 60970],
    ['cake', 60970],
    ['vicky', 60970]
  ];
  void name() {
    for (var i = 0; i < foodList.length; i++) {
      data = foodList[i][0];
      print(data);
    }
  }

  List<String> Food = [];

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
              for (var i = 0; i < foodList.length; i++) {
                data = foodList[i][0];
                print(data);
                print("\n");
              }
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  name();
                  // _textEditingController.clear();
                },
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
              crossAxisCount: 5, childAspectRatio: 3, crossAxisSpacing: 12),
          itemCount: _textEditingController.text.isNotEmpty
              ? foodListOnSearch.length
              : foodList.length,
          itemBuilder: (context, index) {
            //print(index);
            //print(foodList);
            //print(foodList[index]);
            //print(foodList[index][0]);
            print(foodList[index][1]);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(IconData(foodList[index][1],
                        fontFamily: 'MaterialIcons')),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(_textEditingController.text.isNotEmpty
                      ? foodListOnSearch[index]
                      : foodList[index][0]),
                ],
              ),
            );
          }),
    );
  }
}
