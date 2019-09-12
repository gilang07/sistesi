import 'dart:convert';
import 'DataUser.dart';

LoginResult loginResultFromJson(String str) => LoginResult.fromJson(json.decode(str));

String loginResultToJson(LoginResult data) => json.encode(data.toJson());

class LoginResult {
  DataUser data;
  String status;
  String message;

  LoginResult({this.data, this.status, this.message});

  factory LoginResult.fromJson(Map<String, dynamic> json) => new LoginResult(
    data: DataUser.fromJson(json["data"]) ?? [],
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