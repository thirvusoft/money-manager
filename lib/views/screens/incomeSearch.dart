import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class incomeSearch extends StatefulWidget {
  const incomeSearch({Key? key}) : super(key: key);

  @override
  _incomeSearchState createState() => _incomeSearchState();
}

class _incomeSearchState extends State<incomeSearch> {
  TextEditingController _textEditingController = TextEditingController();
  List icon_nameOnSearch = [];
  List icon_name = [
    ['Salary', 61505],
    ['Asset Sale', 0xf2ee],
    ['Scrap Sale', 989624],
    ['Rental', 0xf244],
    ['Refunds', 0xf2d6],
    ['Coupons', 0xf3f6],
    ['Lottery', 0xf3e8],
    ['Dividends', 0xf0617],
    ['Business profit', 0xee35],
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
