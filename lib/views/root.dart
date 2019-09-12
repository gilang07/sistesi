import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'login.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  var num = 1;

  void _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'login';
    final value = prefs.getString(key) ?? "";
    if (value != "" || value.isNotEmpty) {
      setState(() {
       num = 2; 
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    _read();

    // cek login
    if (num == 1) {
      return Login();
    } else {
      return Home();
    }
  }
}