import 'dart:developer';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  isKeyAvailable(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) != null ? true : false;
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    // return json.decode(prefs.getString(key) ?? "");
    return prefs.getString(key) ?? "";
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.setString(key, json.encode(value));
    prefs.setString(key, "$value");
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}