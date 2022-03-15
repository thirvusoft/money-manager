import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future login(email, password) async {
  var passwordcontroller;
  var emailcontroller;
  if (passwordcontroller.text.isNotEmpty || emailcontroller.text.isNotEmpty) {
    print('email');
    print(dotenv.env['API_URL']);

    var response = await http.post(Uri.parse(
        "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.login?email=${email}&password=${password}"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", json.decode(response.body)['token']);
      print(prefs.getString("token"));
      prefs.setString("email", json.decode(response.body)['email']);
      print(prefs.getString("email"));
    }
  }
}

Future profile() async {
  print('profile');
  print(dotenv.env['API_URL']);
  var email;
  var response = await http.post(Uri.parse(
      "${dotenv.env['API_URL']}/api/method/money_management_backend.custom.py.api.profile?email=${email}"));
  print('response');
  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mobile_number",
        json.decode(response.body)['message']['mobile_number']);
    prefs.setString(
        "full_name", json.decode(response.body)['message']['full_name']);
    prefs.setString("email", json.decode(response.body)['message']['email']);
    print(prefs.getString("full_name"));
    print(prefs.getString("mobile_number"));
    print(prefs.getString("email"));
    print(prefs.getString("token"));
  }
}

Future reset(email) async {
  print(email);
  print(dotenv.env['API_URL']);

  var emailcontroller;
  if (emailcontroller.text.isNotEmpty) {
    var response = await http.post(Uri.parse(
        "${dotenv.env['API_URL']}/api/method/frappe.core.doctype.user.user.reset_password?user=${email}"));
    print(response.statusCode);
  }
}
