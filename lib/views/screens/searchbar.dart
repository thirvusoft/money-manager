import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Settings/Asset.dart';

class searchbar extends StatefulWidget {
  const searchbar({Key? key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  final List<IconData> icons = [
    Icons.sentiment_very_dissatisfied,
    Icons.home,
    Icons.drafts,
    Icons.backspace
  ];
  TextEditingController _textEditingController = TextEditingController();
  List<String> foodListOnSearch = [];
  List<String> foodList = [
    'Orange',
    'Berries',
    '5',
    'Lemons',
    'Apples',
    'Mangoes',
    'Dates',
    'Avocados',
    'Black Beans',
    'Chickpeas',
    'Pinto beans',
    'White Beans',
    'Green lentils',
    'Split Peas',
    'Rice',
    'Oats',
    'Quinoa',
    'Pasta',
    'Sparkling ',
    'Coconut ',
    'Herbal tea',
    'Kombucha',
    'Almonds',
    'Peannuts',
    'Chia seeds',
    'Flax seeds',
    'Canned ',
    'Olive oil',
    'Broccoli',
    'Onions',
    'Garlic',
    'Carots',
    'Leafy greens',
    'Meat',
  ];

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
                foodListOnSearch = foodList
                    .where((element) =>
                        element.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Asset()),
                  );
                  _textEditingController.clear();
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
              crossAxisCount: 2, childAspectRatio: 3, crossAxisSpacing: 12),
          itemCount: _textEditingController.text.isNotEmpty
              ? foodListOnSearch.length
              : foodList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.ac_unit_outlined),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(_textEditingController.text.isNotEmpty
                      ? foodListOnSearch[index]
                      : foodList[index]),
                ],
              ),
            );
          }),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;

  Mycard(this.icon, this.title, this.isActive);
}
