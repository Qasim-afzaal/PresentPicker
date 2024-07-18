import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/Utils.dart';

Future<dynamic> callAPI(datarequest, myurl, authToken) async {
  final url ="https://test.thegiftguide.com/api/user/login";
  // Utils.loginURL;
  print("The my url: $myurl"); 
  print("this is api call $datarequest $url  $authToken");
  try {
    final response = await http.post(Uri.parse('$url'),
        headers: authToken != null
            ? {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: "Bearer $authToken"
              }
            : {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(datarequest));
    print("this is response of Api call ${json.decode(response.body)}");
    if (response.statusCode == 200) {
      print("${response.statusCode}");
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  } catch (e) {
    print("The error$e");
    Map<String, dynamic> response = {
      "statusCode": 400,
      "message": "No internet connection"
    };
    return response;
  }
}

Future<dynamic> callAPI2(datarequest, myurl, authToken) async {
  final url = Utils.scrappingURL;
  // "https://test.thegiftguide.com/api/scrape";
  print("The my url: $myurl"); 
  print("this is api call $datarequest $url  $authToken");
  try {
    final response = await http.post(Uri.parse('$url'),
        headers: authToken != null
            ? {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: "Bearer $authToken"
              }
            : {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(datarequest))
.timeout(const Duration(seconds: 30));
        ;
    print("this is response of Api call ${json.decode(response.body)}");


    if (response.statusCode == 200) {
      print("${response.statusCode}");
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }on TimeoutException catch (e) {
  // handle timeout
  Map<String, dynamic> response = {
      "statusCode": 500,
      "message": "Status Timeout"
    };
} 
  catch (e) {
    print("The error$e");
    Map<String, dynamic> response = {
      "statusCode": 400,
      "message": "No internet connection"
    };
    return response;
  }
}