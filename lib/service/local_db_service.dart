import 'dart:convert';
import 'package:present_picker/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDbService {
  static const String _userTokenKey = 'user_token';
  static const String _userEmailKey = 'user_email';
  static const String _userDataKey = 'user_key';
  static const String _loginTimeKey = 'login_time';

  static Future<User> get getUserData async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userDataKey);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    } else {
      throw Exception("No User Found");
    }
  }

  static Future<bool> get checkLastOnlineTime async {
    var prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(_loginTimeKey) ?? "";
    if (value == "") {
      return false;
    } else {
      DateTime lastLoginTime = DateTime.parse(value);
      // print(lastLoginTime);
      DateTime currentTime = DateTime.now();
      if (currentTime.difference(lastLoginTime).inHours > 3) {
        return false;
      } else {
        return true;
      }
    }
  }

  static Future<String> get retrieveToken async {
    var prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(_userTokenKey) ?? "";
    return value;
  }

  static Future<String> get retrieveEmail async {
    var prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(_userEmailKey) ?? "";
    return value;
  }

  static Future<bool> saveLoginStatus(String token, String email, User user) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      DateTime now = DateTime.now();
      prefs.setString(_loginTimeKey, now.toIso8601String());
      prefs.setString(_userTokenKey, token);
      prefs.setString(_userEmailKey, email);
      prefs.setString(_userDataKey, jsonEncode(user.toJson()));
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future clearKeys() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("LoginStatus");
    prefs.remove("UserToken");
    prefs.remove("UserEmail");
  }
}
