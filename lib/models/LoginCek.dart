import 'dart:convert';
import 'package:sistesi/models/KodeSekolah.dart';

LoginCek loginCekFromJson(String str) => LoginCek.fromJson(json.decode(str));

String loginCekToJson(LoginCek data) => json.encode(data.toJson());

class LoginCek {
  KodeSekolah data;
  String status;
  String message;

  LoginCek({this.data, this.status, this.message});

  factory LoginCek.fromJson(Map<String, dynamic> json) => new LoginCek(
    data: KodeSekolah.fromJson(json["data"]) ?? [],
    status: json['status'],
    message: json['message'],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson() ?? [],
    "status": status,
    "message": message,  
  };
}

// class Status {
//   String status;
//   Status({this.status});

//   factory Status.fromJson(Map<String, dynamic> json) => new Status(
//     status: json['status'],
//   );

//   Map<String, dynamic> toJson() => {
//     "status": status,
//   };
// }