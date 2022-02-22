import 'dart:js';

import 'package:flutter/material.dart';

class MyHomePage1 extends StatelessWidget {
  List<Mycard> mycard = [
    Mycard(Icons.shopping_cart, 'Buying', false),
    Mycard(Icons.shop, 'Selling', false),
    Mycard(Icons.account_balance, 'Trades', false),
    Mycard(Icons.play_circle_outline, 'Videos', false),
    Mycard(Icons.people_outline, 'Deal', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
  ];
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
                  ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        Navigator.pop(ctx);
                      })
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: mycard
                    .map(
                      (e) => InkWell(
                        onTap: () => _show(context),
                        child: Card(
                          shape: CircleBorder(),
                          color: e.isActive ? Colors.white : Colors.grey[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                e.icon,
                                size: 15,
                                color: e.isActive ? Colors.white : Colors.black,
                              ),
                              SizedBox(
                                height: 1,
                                width: 2,
                              ),
                              Text(
                                e.title,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: e.isActive
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
      // bottomNavigationBar: home_page(),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;

  Mycard(this.icon, this.title, this.isActive);
}
