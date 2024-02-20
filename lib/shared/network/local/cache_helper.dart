import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }


  static bool? getBool({
    required String key,
  }) => sharedPreferences.getBool(key);

  static String? getString({
    required String key,
  }) =>  sharedPreferences.getString(key);

  static int? getInt({
    required String key,
  }) =>  sharedPreferences.getInt(key);

  static double? getDouble({
    required String key,
  }) =>  sharedPreferences.getDouble(key);

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if(value is String) return await sharedPreferences.setString(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

}