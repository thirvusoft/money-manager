import 'dart:js';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/widgets/curvedNavigation.dart';

class MyHomePage1 extends StatelessWidget {
  List<Mycard> mycard = [
    Mycard(Icons.tv, 'Home Appliances', false),
    Mycard(Icons.bike_scooter, 'Vehcile', false),
    Mycard(Icons.play_circle_outline, 'Videos', false),
    Mycard(Icons.agriculture, 'Agriculture land', false),
    Mycard(Icons.landscape, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
    Mycard(Icons.bookmark_border, 'Case Study', false),
  ];

  get subtypewise_icon_list => null;

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
                  AnimatedButton(
                    text: 'SUBMIT',
                    color: Color.fromARGB(255, 197, 105, 14),
                    pressEvent: () {
                      List<Mycard> mycard = [];
                      for (var subtypewise_icon_list in [
                        ['Income', 'Gold', 'Icons.coin'],
                        ['Expense', 'Health', 'Icon.add']
                      ]) print(subtypewise_icon_list[2]);
                      {
                        mycard.add(Mycard(subtypewise_icon_list[2],
                            subtypewise_icon_list[1], false));
                      }

                      // print(Icon);

                      // AwesomeDialog(
                      //   context: ctx,
                      //   dialogType: DialogType.SUCCES,

                      //   //headerAnimationLoop: false,
                      //   // animType: AnimType.TOPSLIDE,
                      //   // showCloseIcon: true,
                      //   // closeIcon: Icon(Icons.close_fullscreen_outlined),
                      //   title: 'Submit Successfully',
                      //   btnOkOnPress: () {

                      //     Navigator.pop(ctx);
                      //   },
                      // )..show();

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
                    },
                  ),
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
            //   child: new Stack(
            // children: <Widget>[
            //   // The containers in the background
            //   new Column(
            //     children: <Widget>[
            //       new Container(
            //         height: MediaQuery.of(context).size.height * .25,
            //         color: Colors.blue,
            //       ),
            //       new Container(
            //         height: MediaQuery.of(context).size.height * .25,
            //         color: Colors.white,
            //       )
            //     ],
            //   ),
            //   // The card widget with top padding,
            //   // incase if you wanted bottom padding to work,
            //   // set the `alignment` of container to Alignment.bottomCenter
            //   new Container(
            //       alignment: Alignment.topCenter,
            //       padding: new EdgeInsets.only(
            //           top: MediaQuery.of(context).size.height * .58,
            //           right: 20.0,
            //           left: 20.0),
            //       child: new Container(
            //         height: 200.0,
            // width: MediaQuery.of(context).size.width,
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
          ) //)
        ],
      ),
      // bottomNavigationBar: MainScreen(),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;

  Mycard(this.icon, this.title, this.isActive);
}
