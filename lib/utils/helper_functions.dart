import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String myFormatDate(DateTime dt, {String format = "dd/MM/yyyy"}) {
  return DateFormat(format).format(dt);
}

String formatTimeCustom(TimeOfDay timeOfDay, {String pattern = 'HH:mm'}) {
  return DateFormat(pattern).format(DateTime(0, 0, 0, timeOfDay.hour, timeOfDay.minute));
}

void showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    ),
  );
}

Future<bool> saveToken(String token) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.setString(accessToken, token);
}

Future<String> getToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.getString(accessToken) ?? "";
}

Future<bool> saveLoginTime(int time) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.setInt(loginTime, time);
}

Future<int> getLoginTime() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.getInt(loginTime) ?? 0;
}

Future<bool> saveExpirationDuration(int duration) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.setInt(expirationDuration, duration);
}

Future<int> getExpirationDuration() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.getInt(expirationDuration) ?? 0;
}

Future<bool> hasTokenExpired() async {
  final loginTime = await getLoginTime();
  final expirationDuration = await getExpirationDuration();

  return DateTime.now().millisecondsSinceEpoch - loginTime > expirationDuration;
}
