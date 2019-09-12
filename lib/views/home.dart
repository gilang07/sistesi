import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
  }

  showNotification(String title, String desc, String payload) async {
    var android = new AndroidNotificationDetails('sistesi', 'sistesi2', 'sistesi3',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform  = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, title, desc, platform,
        payload: payload);
  }
  
  localNotificationSetup() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings, 
      onSelectNotification: onSelectNotification);
  }
  
  @override
  void initState() {
    super.initState();
    localNotificationSetup(); // setup local notification
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        final notification = message['notification'];
        final data = message['data'];
        print("message onMessage {$message}");
        print("dibawah adalah isi notif");
        print(notification['title']);
        print(notification['body']);
        var customPayload = "";
        final tipe = data['title'];
        final kode = data['body'];
        final flag = data['idnotif'];
        customPayload = tipe + "," + kode + "," + flag;
        showNotification(data["title"],
            data["body"], customPayload);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("message onLaunch {$message}");
      },
      onResume: (Map<String, dynamic> message) async {
        print("message onResume {$message}");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text("Home"),
      ),
      body: new Center(
        child: new IconButton(
          icon: new Icon(Icons.headset, size: 50.0),
          onPressed: () {
            _showDialog();
          },
        )
      )
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type dialog
        return AlertDialog(
          content: Text('Anda yakin ingin keluar?'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Batal',  
                style: TextStyle(
                  color: Colors.orange
                  ),
                ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Iya',
                style: TextStyle(
                  color: Colors.orange
                  ),
                ),
              onPressed: () {
                _logOut();
              },
            ),
          ],
        );
      }
    );
  }

  Future _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}