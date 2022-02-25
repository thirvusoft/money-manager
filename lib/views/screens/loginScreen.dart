import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:money_manager/views/categories/assets.dart';
import 'package:money_manager/views/screens/Animation/FadeAnimation.dart';
import 'package:money_manager/views/screens/forgetpasswordscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/flutter_login.dart';

bool _securetext = true;
const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);
  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final formKey = GlobalKey<FormState>();

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  get scaffoldMessenger => null;

  get email => null;

  get password => null;

  set isLoading(bool isLoading) {}
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
                            SizedBox(
                              height: 30,
                            ),
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
                                          : Icons.lock_open),
                                      onPressed: () {
                                        setState(() {
                                          _securetext = !_securetext;
                                        });
                                      },
                                    )),
                                validator: (value) {
                                  if (value!.trim().isEmpty ||
                                      !RegExp(r'.{8,}$').hasMatch(value)) {
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
                              // Login();
                              // if (formKey.currentState!.validate()) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //           content: Text("Successfully login")));
                              // }
                            },
                            child: const Text(
                              'LOGIN',
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
//   bool visible = false;

//   // Getting value from TextField widget.

//   Future Login() async {
//     // Showing CircularProgressIndicator.
//     setState(() {
//       visible = true;
//     });

//     // Getting value from Controller

//     // SERVER LOGIN API URL
//     var url =
//         'http://192.168.24.101:8000/api/method/money_management_backend.custom.py.api.login';

//     // Store all data with Param Name.
//     var data = {'email': email, 'password': password};

//     // Starting Web API Call.
//     var response = await http.post(, body: json.encode(data[email]));
//     print(data);

//     // Getting Server response into variable.
//     var message = jsonDecode(response.body);
//     print(message);

//     // If the Response Message is Matched.
//     if (message == 'success') {
//       // Hiding the CircularProgressIndicator.
//       setState(() {
//         visible = false;
//       });

//       // Navigate to Home & Sending Email to Next Screen.
//       Navigator.pushNamed(context, '/home');
//     } else {
//       // If Email or Password did not Matched.
//       // Hiding the CircularProgressIndicator.
//       setState(() {
//         visible = false;
//       });
//     }
//   }
// }

//   Future<void> login() async {
//     var completer = new Completer();
//     if (passwordcontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty) {
//       var response = await http.get(
//           Uri.parse(
//               "http://192.168.24.101:8000/api/method/money_management_backend.custom.py.api.login"),
//           headers: ({
//             'email': emailcontroller.text,
//             'password': passwordcontroller.text,
//             "Access-Control-Allow-Origin": "*",
//             "Accept": "application/json"
//                 "Access-Control-Allow-Methods"
//           }));
//       if (response.statusCode == 200) {
//         print('email');
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => MyHomePage()),
//         // );
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Invalid")));
//       }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Invalid field")));
//     }
//     return completer.future;
//   }

