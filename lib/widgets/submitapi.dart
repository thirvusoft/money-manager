import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Duration get loginTime => Duration(milliseconds: 2250);
Future<String> submit() async {
  Uri url = Uri.parse(
      "http://192.168.24.101:8000/api/method/money_management_backend.custom.py.api.daily_entry_submit?Type=Asset&Subtype=70&IconBineryCode=t");
  print(Object);

  final response = await http.get(url);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.statusCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('type', 'asset');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('subtype', '53');
    preferences.setString('IconBineryCode', 't');
    var res = json.decode(response.body);
    print(res);
    if (res['message'] == 'Submitted') {
      print(res['message']);
    }
  }
  if (response.statusCode == 300) {
    var res = json.decode(response.body);
    return res['message'];
  } else {
    return "Invalid submit Credentials";
  }
}

Future<String> _recoverPassword(String name) async {
  return Future.delayed(loginTime).then((_) {
    return "";
  });
}
