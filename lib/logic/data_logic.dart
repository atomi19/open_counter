import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveBool(String key, bool data) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setBool(key, data);
}

Future<void> saveInt(String key, int data) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setInt(key, data);
}