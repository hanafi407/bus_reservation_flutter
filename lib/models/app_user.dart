// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  int? id;
  String userName;
  String password;
  String role;

  AppUser({
    this.id,
    required this.userName,
    required this.password,
    this.role = 'ADMIN',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'password': password,
      'role': role,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        id: json['id'],
        userName: json['userName'],
        password: json['password'],
        role: json['role'],
      );
}
