import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
//import 'dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'package:money_manager/views/screens/landingScreen.dart';
import 'dart:convert';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class landing_screen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

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
    debugPrint('Name: $name');

    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "test";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      hideForgotPasswordButton: true,
      logo: AssetImage('assets/images/coin.png'),
      onLogin: login,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => home_page(),
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
