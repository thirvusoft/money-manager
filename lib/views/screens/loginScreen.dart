import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
//import 'dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:money_manager/widgets/curvedNavigation.dart';

class landing_screen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> login(LoginData data) async {
    Uri url = Uri.parse(
        "http://192.168.24.16:8002/api/method/money_management_backend.custom.py.api.login?email=${data.name}&password=${data.password}");
    print('object');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      if (res['message'] == 'Logged In') {
        return null;
      }
    }
    if (response.statusCode == 300) {
      var res = json.decode(response.body);
      return res['message'];
    } else {
      return "Invalid Login Credentials";
    }
  }

  Future<String> _recoverPassword(String name) async {
    return Future.delayed(loginTime).then((_) {
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideForgotPasswordButton: true,
      logo: const AssetImage('assets/images/money.png'),
      onLogin: login,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.blue[900],
        textFieldStyle: TextStyle(
          color: Colors.orange,
          shadows: [Shadow(color: Colors.grey, blurRadius: 2)],
        ),
        titleStyle: TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Noto Sans Japanese',
          letterSpacing: 4,
        ),
      ),
    );
  }
}
