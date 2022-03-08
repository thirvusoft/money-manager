import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manager/views/screens/Animation/FadeAnimation.dart';
import 'package:money_manager/views/screens/forgetpasswordscreen.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/flutter_login.dart';

import '../../widgets/BottomNavigation.dart';

bool _securetext = true;

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);
  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
void _doSomething() async {
    Timer(Duration(seconds: 1),() {
     
        _btnController.reset(
          
        );
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
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
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          )),
                      Positioned(
                          left: 130,
                          width: 80,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
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
                                    controller: emailcontroller,
                                    decoration: InputDecoration(
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
                                Divider(),
                                
                                FadeAnimation(
                                  1,
                                  TextFormField(
                                    controller: passwordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        suffixIcon: IconButton(
                                          icon: Icon(_securetext
                                              ? Icons.lock_clock_outlined
                                              : Icons.lock_open,color: Color.fromRGBO(143, 148, 251, 1),),
                                          onPressed: () {
                                            setState(() {
                                              _securetext = !_securetext;
                                            });
                                          },
                                        )),
                                    validator: (value) {
                                      if (value!.trim().isEmpty ||
                                          !RegExp(r'.{6,}$').hasMatch(value)) {
                                        return "Invalid password";
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: _securetext,
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          
                          RoundedLoadingButton(
                            color: Color.fromRGBO(143, 148, 251, 1),
    child: Text('Login', style: TextStyle(color: Colors.white)),
    controller: _btnController,
    onPressed: () {
          _doSomething();
          if (formKey.currentState!.validate()) {
          login(emailcontroller.text,
          passwordcontroller.text);
          }},
          ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      FadeAnimation(
                          2.5,
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => forget_password()),
                              );
                            },
                            child: const Text(
                              'Forget Password ?',
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  fontSize: 15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future login(email, password) async {
    if (passwordcontroller.text.isNotEmpty || emailcontroller.text.isNotEmpty) {
      print('email');
      var response = await http.post(Uri.parse(
          "http://192.168.24.34:8000/api/method/money_management_backend.custom.py.api.login?email=${email}&password=${password}"));
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Email Send successful"),
          backgroundColor: Colors.green,
        ));
      } else if (response.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(" Access Denied."),
          backgroundColor: Colors.red,
        ));
      } else if (response.statusCode == 503) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("service unavailable"),
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