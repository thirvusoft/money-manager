import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_manager/widgets/curvedNavigation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class landing_screen extends StatefulWidget {
  @override
  State<landing_screen> createState() => _landing_screenState();
}

class _landing_screenState extends State<landing_screen> {
  final _formkey = GlobalKey<FormState>();
  final _formkeys = GlobalKey<FormState>();
  //const landing_screen({ Key? key }) : super(key: key);
  final password = TextEditingController();
  final emailid = TextEditingController();
  _openPopup(context) {
    Alert(
        context: context,
        title: "Login",
        content: Column(
          children: [
            Form(
              key: _formkey,
              child: TextFormField(
                controller: emailid,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.account_circle),
                  labelText: "Mobile Number",
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Mobile Number";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            TextFormField(
              key: _formkeys,
              obscureText: true,
              controller: password,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.lock),
                labelText: "Password",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Password";
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
        buttons: [
          DialogButton(
            child: const Text("Login", style: TextStyle(color: Colors.white)),
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Sucessfully login",
                      style: TextStyle(color: Colors.white70))));
              // var _password = password.value;
              // var _emailid = emailid.value;
              // setState(() {
              //   if ((password.text.isEmpty
              //       ? _validate = true
              //       : _validate = true))
              //     ;
              //   else {
              //     //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Login Suceessfully",style: TextStyle(color: Colors.white),)));
              //   }
              // });
              //  {
              //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please enter all the fields",style: TextStyle(color: Colors.white70))));
              // }
            },
            color: Colors.blue[900],
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            //
            Container(
              child: SvgPicture.asset(
                'assets/images/login.svg',
                width: 450,
                height: 450,
              ),
            ),
            // Container(
            //   child: MaterialButton(
            //     height: 50.0,
            //     minWidth: 100.0,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10))),
            //     child: Text(
            //       "Suggestion",
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     onPressed: () {
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //       builder: (context) => suggestion_screen()),
            //       // );
            //     },
            //     color: Colors.blue[800],
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: MaterialButton(
                height: 50.0,
                minWidth: 103.0,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(10))),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _openPopup(context);
                },
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Future<void> login() async{
  //   await http.post
  //}
}
