import 'package:flutter/material.dart';
import 'views/root.dart';
import 'views/home.dart';
import 'views/login.dart';

void main() => runApp(MaterialApp(
  title: "Sistesi",
  initialRoute: '/',
  routes: {
    '/': (context) => Root(),
    '/login': (context) => Login(),
    '/home': (context) => Home(),
  }
));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: new Login()
      ),
      routes: <String, WidgetBuilder> {
        '/main' : (BuildContext context) => MyApp()    
      }
    );
  }
}
