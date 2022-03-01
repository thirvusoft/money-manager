import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_manager/views/screens/Animation/FadeAnimation.dart';

class Liability extends StatefulWidget {
  @override
  State<Liability> createState() => _LiabilityState();
}

class _LiabilityState extends State<Liability> {
  // final _text = TextEditingController();
  bool _validate = false;
  final formKey = GlobalKey<FormState>();

  List mycard = [
    Mycard(Icons.agriculture, '', false),
    Mycard(Icons.car_repair, '', false),
    Mycard(Icons.bike_scooter, '', false),
    Mycard(Icons.local_airport, '', false),
    Mycard(Icons.bus_alert, '', false),
    Mycard(Icons.add_call, '', false),
    Mycard(Icons.shop, '', false),
    Mycard(Icons.account_balance, '', false),
    Mycard(Icons.play_circle_outline, '', false),
    Mycard(Icons.people_outline, '', false),
    Mycard(Icons.food_bank, '', false),
    Mycard(Icons.agriculture, '', false),
    Mycard(Icons.car_repair, '', false),
    Mycard(Icons.bike_scooter, '', false),
    Mycard(Icons.local_airport, '', false),
    Mycard(Icons.bus_alert, '', false),
    Mycard(Icons.shopping_cart, '', false),
    Mycard(Icons.shop, '', false),
  ];

  void show(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        isScrollControlled: true,
        elevation: 1,
        context: ctx,
        builder: (ctx) => Padding(
            padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                      1,
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Plese Enter the Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    FadeAnimation(
                        2,
                        RaisedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Liability()),
                              );
                            }
                          },
                          child: Text('Submit'),
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                        ))
                  ]),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.count(
                crossAxisCount: 5,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: mycard
                    .map(
                      (e) => InkWell(
                        onTap: () => show(context),
                        child: Card(
                          shape: CircleBorder(),
                          color: e.isActive
                              ? Color.fromARGB(255, 255, 253, 253)
                              : Colors.grey[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                e.icon,
                                size: 35,
                                color: e.isActive
                                    ? Color.fromARGB(255, 255, 254, 254)
                                    : Color.fromARGB(255, 71, 71, 71),
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
                                        : Colors.white),
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
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;

  Mycard(this.icon, this.title, this.isActive);
}