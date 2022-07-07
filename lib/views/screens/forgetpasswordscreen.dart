import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:money_manager/views/screens/Animation/FadeAnimation.dart';
import 'package:money_manager/views/screens/loginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class forget_password extends StatefulWidget {
  const forget_password({Key? key}) : super(key: key);
  @override
  _forget_passwordState createState() => _forget_passwordState();
}

class _forget_passwordState extends State<forget_password> {
  final formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  void _doSomething() async {
    Timer(Duration(seconds: 1), () {
      _btnController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 400,
                decoration: const BoxDecoration(
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
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        )),
                    Positioned(
                        left: 130,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        )),
                    FadeAnimation(
                        0.5,
                        Positioned(
                            child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "FORGET PASSWORD",
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
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
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
                                  controller: emailcontroller,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                  ),
                                  validator: (value) {
                                    if (value!.trim().isEmpty ||
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
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
                    const SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      1.5,
                      RoundedLoadingButton(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        child: Text('Send Email',
                            style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: () {
                          _doSomething();
                          if (formKey.currentState!.validate()) {
                            reset(
                              emailcontroller.text,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
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
                            MaterialPageRoute(
                                builder: (context) => login_page()),
                          );
                        },
                        child: const Text(
                          'Back to login',
                          style: TextStyle(
                              color: Color.fromARGB(255, 93, 99, 216),
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
      ),
    );
  }

  Future reset(email) async {
    if (emailcontroller.text.isNotEmpty) {
      var response = await http.post(Uri.parse(
          "${dotenv.env['API_URL']}/api/method/frappe.core.doctype.user.user.reset_password?user={{email}}"));
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => login_page()),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.green,
        ));
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 417) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 503) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode('message')),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
