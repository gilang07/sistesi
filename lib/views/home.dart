import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sistesi/models/DataNotif.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int counter = 0;
  // DataNotif dataNotif;
  List notif = [];
  List<DataNotif> listChat = List<DataNotif>();
  SharedPreferences sharedPreferences;
  var totalChat = 0;
  var totalNotif = 0;

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
    );
  }

  Future onSelectNotification(String payload) {
    debugPrint("payload : $payload");
  }

  showNotification(String title, String desc, String payload) async {
    var android = new AndroidNotificationDetails(
        'sistesi', 'sistesi2', 'sistesi3',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
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

  Future setChat(data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "chat";
    // final idnotif = this.notif[0]["idnotif"];
    // final idPenerima = this.notif[0]["id_penerima"];
    // final jenisPenerima = this.notif[0]["jenis_penerima"];
    // final jenisPengirim = this.notif[0]["jenis"];
    // final customData =
    //     idnotif + "," + jenisPenerima + "," + jenisPengirim + "," + idPenerima;
    prefs.setString(key, data);
    final result = prefs.getString(key);
    setState(() {
      totalChat = json.decode(result).length;
    });
    return result;
  }

  Future getChat() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "chat";
    final result = prefs.getString(key) ?? "";
    if (totalChat == 0 && result != "") {
      // cek buka aplikasi
      setState(() {
        totalChat = json.decode(result).length;
        notif.add(json.decode(result));
        print('data notif json decode ');
        print(notif);
        return result;
      });
    } else {
      return result;
    }
    // totalChat = json.decode(result[0]).length;
    // List<dynamic> list = result;
  }

  Future loadTotalChat() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "chat";
    final result = prefs.getString(key) ?? "";
    // List<String> a = ["null"];
    // print(result[0]);
    // print(result.runtimeType);
    // print(result);
    // print(a);
    // print(a.runtimeType);
    // print(a[0] == result[0]);
    if (result != "" || result.isNotEmpty && totalChat == 0) {
      setState(() {
        totalChat = json.decode(result).length;
        print(result.runtimeType);
        print(result.length);
        // final substring = result.substring(0);
        // final a = result.substring(0);
        print(result);
        // print(a);
        notif.add(json.decode(result.substring(0)));
        print('data notif.add() json.decode(result)');
        print(notif);
        print(notif[0]);
        // print("data notif loadTotalChat");
        // print(result);
        // print(result.runtimeType);
        // print(json.decode(result[0]).runtimeType);
      });
      // print(result);
    }
  }

  Future clearChat() async {
    final prefs = await SharedPreferences.getInstance();
    final key = "chat";
    prefs.remove(key);
  }

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadNotifChat();
  }

  void removeNotifChat(DataNotif item) {
    listChat.remove(item);
    if (listChat.isEmpty) setState(() {});
    saveNotifChat();
  }

  void addNotifChat(DataNotif item) {
    print("tes add");
    listChat.insert(0, item);
    saveNotifChat();
  }

  void loadNotifChat() {
    List<String> spChat = sharedPreferences.getStringList('chat');
    if (spChat != null) {
      listChat =
          spChat.map((item) => DataNotif.fromMap(json.decode(item))).toList();
      setState(() {
        totalChat = listChat.length;
      });
    }
  }

  void saveNotifChat() {
    List<String> stringList =
        listChat.map((item) => json.encode(item.toMap())).toList();
    print("dibawah  data saveNotifChat");
    print(stringList);
    sharedPreferences.setStringList('chat', stringList);
  }

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
    localNotificationSetup(); // setup local notification
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // notif = message["data"];
        print(message["data"]);
        final idnotif = message["data"]["idnotif"];
        final idPenerima = message["data"]["id_penerima"];
        final jenisPenerima = message["data"]["jenis_penerima"];
        final jenisPengirim = message["data"]["jenis"];
        var payload = "";
        payload = idnotif +
            "," +
            jenisPenerima +
            "," +
            jenisPengirim +
            "," +
            idPenerima;
        addNotifChat(DataNotif(
            idNotif: idnotif,
            idPenerima: idPenerima,
            jenisPenerima: jenisPenerima,
            jenisPengirim: jenisPengirim));
        initSharedPreferences();
        showNotification(message["data"]["title"],
            message["data"]["body"], payload);
        // print("message onMessage {$message}");
        // print(json.encode(message["data"]));
        // notif.add(message['data']);
        // print(notif);
        // print(" data notif list {$notif}");
        // print(json.encode(notif));
        // // var isiPesan = message['data'];
        // var payload = "";
        //     print("data sebelum di encode");
        //     print(notif);
        // setChat(json.encode(notif)).then((onValue) {
        // print(onValue.runtimeType);
        // print(onValue);
        // print("data setelah di decode");
        // print(json.decode(onValue));
        // });
        // loadTotalChat();
        // print(notif);
        // print("dibawah data notif");
        // print(notif);
        // final notification = message['notification'];
        // final data = message['data'];
        // print("message onMessage {$message}");
        // print("dibawah adalah isi notif");
        // print(notification['title']);
        // print(notification['body']);
        // var customPayload = "";
        // final tipe = data['title'];
        // final kode = data['body'];
        // final idNotif = data['idnotif'];
        // print(data);
        // print(notif.length);
        // loadTotalChat();
        // getChat().then((onValue) {
        //   print("data getChat() {$onValue}");
        // });
        // payload = idnotif + "," + idPenerima + "," + jenisPengirim + "," + jenisPenerima;

        // getChat().then((onValue) {
        //   print("data result chat dibawah");
        //   print(onValue);
        //   print("dibawah data notif kuy");
        //   // final tes = onValue;
        //   // print(tes);
        //   // print(tes.length);
        //   // final cast = json.decode(onValue);
        //   // List<String> tes = onValue[0];
        //   // print(tes);
        //   // print(tes.length);
        //   print(onValue[0]);
        //   print(onValue[0].runtimeType);
        //   print(json.decode(onValue[0]).length);
        //   // print(tes.length);
        // });
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
    // loadTotalChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            new Stack(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    iconSize: 30.0,
                    color: Colors.blue,
                    onPressed: () async {
                      clearChat();
                    }),
                totalChat != 0
                    ? new Positioned(
                        right: 11,
                        top: 11,
                        child: new Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            '$totalChat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : new Container()
              ],
            )
          ],
        ),
        body: new Center(
          child: new IconButton(
            icon: new Icon(
              Icons.notifications_none,
              size: 50.0,
            ),
            color: Colors.blue,
            onPressed: () {
              _showDialog();
            },
          ),
        ));
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
                  style: TextStyle(color: Colors.orange),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Iya',
                  style: TextStyle(color: Colors.orange),
                ),
                onPressed: () {
                  _logOut();
                },
              ),
            ],
          );
        });
  }

  Future _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    showToast("Logged Out");
  }
}
