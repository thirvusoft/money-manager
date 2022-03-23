import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:money_manager/views/screens/loginScreen.dart';
import 'package:money_manager/views/screens/splash_screen.dart';

class Profiles extends StatefulWidget {
  Profiles({Key? key}) : super(key: key);
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  int? mobile;
  bool isLoading = false;
  String? fname;
  String? mail;
  var email;
  // void main() async {
  //   await checkupdateNeeded(email);
  // }

  bool _loading = false;
  void initState() {
    profile(email);
    checkupdateNeeded(email);

    super.initState();
    checkupdateNeeded(email);
    Future.delayed(Duration(seconds: 1), () {
      Color.fromARGB(255, 93, 99, 216);
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkupdateNeeded(email) async {
    await profile(email);
    _loading = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile = prefs.getInt('mobile');
    fname = prefs.getString("name");
    mail = prefs.getString("email");
    print(fname);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: _loading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 93, 99, 216)),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        fname ?? '',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      SizedBox(
                        height: 16,
                      ),
                      Text(mail ?? ''),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      SizedBox(
                        height: 16,
                      ),
                      Text('$mobile'),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      SizedBox(
                        height: 16,
                      ),
                      FlatButton(
                        child: Text(
                          'Logout',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        color: Color.fromARGB(255, 93, 99, 216),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_page()),
                          );
                        },
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
        ));
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration:
            BoxDecoration(color: Color.fromARGB(255, 93, 99, 216), boxShadow: [
          BoxShadow(
              color: Color.fromARGB(255, 233, 231, 230),
              blurRadius: 20,
              offset: Offset(0, 0))
        ]),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);
    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Future profile(email) async {
  bool _loading = false;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('email'));

  var response = await http.post(
      Uri.parse(
          "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.profile?email=${email}"),
      headers: {"Authorization": prefs.getString('token') ?? ""});

  if (response.statusCode == 200) {
    print("hhh");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("email", json.decode(response.body)['message']['email']);
    prefs.setString(
        "mobile", json.decode(response.body)['message']['mobile_number']);
    prefs.setString(
      "name",
      json.decode(response.body)['message']['full_name'],
    );
    print('test');
    print(prefs.getString('full_name'));
  }
}
