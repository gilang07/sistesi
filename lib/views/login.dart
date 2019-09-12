import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistesi/models/DataUser.dart';
import 'package:sistesi/providers/apiservices.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _kodeSekolah = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  ApiServices apiServices;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void showInSnackBar(String val) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(val),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: "Tutup",
          textColor: Colors.blue,
          onPressed: () {},
        )));
  }

  void saveLoginData(data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "login";
    prefs.setString(key, dataUserToJson(data));
    print("dibawah adalah data loginresult");
    print(prefs.getString("login"));
  }

  void setUrlWs(value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "urlWs";
    prefs.setString(key, value);
    print("data urlws "+ prefs.getString("urlWs"));
  }

  @override
  void initState() {
    super.initState();
    apiServices = ApiServices();
  }

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

  void login(String username, String password, String kode) {
    var bodyKode = {"kode": kode};
    apiServices.cekKode(bodyKode).then((value) {
      // jika kode sekolah benar
      if (value.status == 'success') {
        setUrlWs(value.data.urlWs);
        setState(() {
          _saving = true;
        });
        var body = {"username": username, "password": password};
        apiServices.login(body).then((value1) {
          // jika login gagal
          if (value1.status == 'failed') {
            setState(() {
              _saving = false;
            });
            showToast(value1.message);
          } else {
            _firebaseMessaging.getToken().then((String fcmToken) {
              assert(fcmToken != null);
              print(fcmToken);
              var value = {"app_version": "1.1.6", "jenis_login": value1.data.jenisLogin, "id_jenis": value1.data.idJenis, "token": fcmToken};
              apiServices.sendFirebaseKey(value, value1.data.fcmToken);
            });
            saveLoginData(value1.data);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/home', (Route<dynamic> route) => false);
          }
        });
      } else {
        // jika kode sekolah salah 
        showToast(value.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                new Image(
                  image: AssetImage('assets/index.png'),
                  width: 150.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
                new Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Kode Sekolah",
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 70.0, 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) =>
                      val.length < 1 ? 'kode sekolah tidak boleh kosong' : null,
                  keyboardType: TextInputType.text,
                  controller: _kodeSekolah,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Nomer Induk Siswa / Kependidikan",
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                        color: Colors.yellow[800],
                      ),
                    ),

                    //fillColor: Colors.green
                  ),
                  validator: (val) =>
                      val.length < 1 ? 'NIS tidak boleh kosong' : null,
                  keyboardType: TextInputType.text,
                  controller: _username,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                new TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 70.0, 10.0),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                        color: Colors.yellow[800],
                      ),
                    ),

                    //fillColor: Colors.green
                  ),
                  validator: (val) =>
                      val.length < 1 ? 'password tidak boleh kosong' : null,
                  keyboardType: TextInputType.text,
                  controller: _password,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  // match_parent
                  child: new RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      login(_username.text, _password.text, _kodeSekolah.text);
                    },
                    color: Colors.blue[300],
                    child: Text(
                      "MASUK",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
