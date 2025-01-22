// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthResponseModel {
  int statusCode;
  String message;
  String accessToken;
  int logInTime;
  int expirationDuration;

  AuthResponseModel({
    required this.statusCode,
    required this.message,
    required this.accessToken,
    required this.logInTime,
    required this.expirationDuration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
      'accessToken': accessToken,
      'logInTime': logInTime,
      'expirationDuration': expirationDuration,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      statusCode: (map['statusCode'] ?? 0) as int,
      message: (map['message'] ?? '') as String,
      accessToken: (map['accessToken'] ?? '') as String,
      logInTime: (map['logInTime'] ?? 0) as int,
      expirationDuration: (map['expirationDuration'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) => AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
