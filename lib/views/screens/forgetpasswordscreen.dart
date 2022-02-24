import 'dart:html';
import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Animation/FadeAnimation.dart';
import 'package:money_manager/views/screens/loginScreen.dart';

class forget_password extends StatefulWidget {
  const forget_password({Key? key}) : super(key: key);

  @override
  _forget_passwordState createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: [
                  Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-1.png'))),
                      )),
                  Positioned(
                      left: 130,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-2.png'))),
                      )),
                  FadeAnimation(
                      0.5,
                      Positioned(
                          child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .3),
                              blurRadius: 40.0,
                              offset: Offset(0, 20)),
                        ]),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            FadeAnimation(
                              1,
                              TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                ),
                                validator: (value) {
                                  print(value);
                                  if (value!.trim().isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value!)) {
                                    return "Invalid email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.5,
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Email send successfully")));
                              }
                            },
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 70,
                  ),
                  FadeAnimation(
                    2,
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login_page()),
                        );
                      },
                      child: const Text(
                        'Back to login',
                        style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                            fontSize: 15,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
