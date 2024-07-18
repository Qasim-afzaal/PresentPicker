import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:present_picker/model/user.dart';
import 'package:present_picker/utils/Utils.dart';


class AuthService {
  Future<Login> onLogin({required String email, required String password}) async {
    var url = Utils.loginURL;
    var body = {'email': email, 'password': password};

    var response = await http.post(Uri.parse(url), body: body);
    Map<String, dynamic> rawResponse = jsonDecode(response.body);
    if (rawResponse["status"]) {
      Login status = loginFromJson(response.body);
      return status;
    } else {
      throw Exception("Incorrect Password");
    }
  }

  Future<bool> checkEmailExist(String email) async {
    var url = Utils.checkEmailExistsURL;
    var body = {'email': email.trim()};
    var response = await http.post(Uri.parse(url), body: body);
    var status = jsonDecode(response.body);
    return status['status'];
  }
}
