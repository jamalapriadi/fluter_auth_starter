import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static getCache({@required dynamic key}) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    final data = prefs.getString('$key');

    return data;
  }

  static getCacheBool({@required dynamic key}) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();

    final SharedPreferences prefs = await prefs0;

    final data = prefs.getBool('$key');

    return data;
  }

  static Future<bool> setCache(
      {@required dynamic key, @required dynamic data}) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await prefs;
    return await pref.setString('$key', data.toString());
  }

  static Future<bool> setCacheBool(
      {@required dynamic key, required bool data}) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    final SharedPreferences pref = await prefs;

    return await pref.setBool('$key', data);
  }

  static Future<bool> removeCache({@required dynamic key}) async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    return await prefs.setString('$key', '');
  }
}
