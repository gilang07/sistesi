import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistesi/models/LoginCek.dart';
import 'package:sistesi/models/LoginResult.dart';

class ApiServices {
  final urlUtama = 'https://sistesi.id/wsdev/public';

  Future<LoginCek> cekKode(value) async {
    final headers = {"Content-Type": "application/json"};
    final body = json.encode(value);
    final response = await http.post("$urlUtama/checkKodeSekolah", headers: headers, body: body);
    final responseResult = json.decode(response.body);
    if (response.statusCode == 200) {
      print('data response dibawah');
      print(json.decode(response.body)); // dilanjut boss
      print(responseResult["status"]);
      // if (responseResult["status"] == "success") {
        final res = LoginCek.fromJson(json.decode(response.body));
        return res;
      // } else {
      //   final res = responseResult;
      //   return res;
      // }
    } else {
      return null;
    }
  }

  Future<LoginResult> login(value) async {
    final headers = {"Content-Type": "application/json"};
    final body = json.encode(value);
    final prefs = await SharedPreferences.getInstance();
    final urlWs = prefs.getString("urlWs");
    final subUrl = "loginCombine";
    final response = await http.post("$urlWs$subUrl", headers: headers, body: body);
    print('response code '+ response.statusCode.toString());
    print('data login result '+ response.body.toString());
    if (response.statusCode == 200) {
      final res = LoginResult.fromJson(json.decode(response.body));
      return res;
    } else {
      return null;
    }
  }

  Future<http.Response> sendFirebaseKey(data, token) async {
    var body = json.encode(data);
    var headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final prefs = await SharedPreferences.getInstance();
    final urlWs = prefs.getString("urlWs");
    final subUrl = "updateTokenFCM";
    var res = await http.post("$urlWs$subUrl", headers: headers, body: body);
    print("data response code sendFirebase ${res.statusCode}");
    print("data response body sendFirebase ${res.body}");
    return res;
  } 
}