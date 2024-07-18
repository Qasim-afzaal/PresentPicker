
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:present_picker/model/user_data_model.dart';
import 'package:present_picker/service/app_service.dart';
import 'package:present_picker/service/callApi.dart';
import 'package:present_picker/shared_preference/shared_pref.dart';
import 'package:present_picker/views/auth/databaseHelperClass/db_class.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../utils/Utils.dart';
import 'package:http/http.dart' as http;

enum States {
  // ignore: constant_identifier_names
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  LoggedOut,
  Failure,
  Loading,
  SingUPScreen,
  passwordScreen,
  Scrapping,
  Success,
  menu,
  onBoard,
  webviewShare,
  oopsLoginReq,
  login
}

enum Statess { Loading, Success, Failure, internet }

class AuthProvider with ChangeNotifier {
  final SharedPref _sharedPref = SharedPref();
  States _loggedInStatus = States.Authenticating;
  States get loggedInStatus => _loggedInStatus;

  States _registeredInStatus = States.NotRegistered;
  States get registeredInStatus => _registeredInStatus;

  Statess _emailResult = Statess.Success;
  Statess get emailResult => _emailResult;

  final TextEditingController textEditingController = TextEditingController();

  LoginData? _user;
  LoginData? get getUser => _user;

  String? _loginErrorMsg;
  String? get loginErrorMsg => _loginErrorMsg;

  String? _passsErrorMsg;
  String? get passsErrorMsg => _passsErrorMsg;

  String? _emailErrorMsg;
  String? get emailErrorMsg => _emailErrorMsg;

  bool? _apiStatus;
  bool? get apiStatus => _apiStatus;

  bool? _apiStatusPass;
  bool? get apiStatusPass => _apiStatusPass;

  String? _token;
  String? get token => _token;

  List<Map<String, dynamic>> _accounts = [];
  List<Map<String, dynamic>> get account => _accounts;

  String? _username;
  String? get username => _username;

  String? _avatar;
  String? get avatar => _avatar;

  Future<void> onLogin(String password) async {
    try {
      _emailResult = Statess.Loading;
      notifyListeners();
      var url = "https://test.thegiftguide.com/api/user/login";
      // Utils.loginURL;
      var body = {'email': _email, 'password': password};

      var res = await callAPI(body, url, "");

      print(res);
      if (res["status"] != false) {
        _emailResult = Statess.Success;
        print(res["data"]);
        print(
            "${res["data"]["token"]}.....${res["data"]["user"]["firstname"]}");

        _token = res["data"]["token"];
        _username = res["data"]["user"]["firstname"] +
            " " +
            res["data"]["user"]["lastname"];
        _avatar = res["data"]["user"]["avatar"];
        print("avatar$_username");
        SharedPref sharedPref = SharedPref();
        sharedPref.save("authUser", res);

        // Check if the account already exists in the database
        _accounts = await DatabaseHelper.instance.getAccounts();
        bool accountExists = _accounts.any((account) =>
            account['email'] == _email && account['token'] == _token);
        print("this os login accountss $_accounts");
        if (!accountExists) {
          // If the account doesn't exist, add it to the database
          await DatabaseHelper.instance
              .addAccount(_email!, _token!, _username!, _avatar!);

          // Update the accounts list after adding the account
          _accounts = await DatabaseHelper.instance.getAccounts();
          notifyListeners();
        }

        homeScreen();
        notifyListeners();
      } else {
        _emailResult = Statess.Failure;
        _passsErrorMsg = res["error"];
        _apiStatusPass = false;

        print("error $_passsErrorMsg");
        notifyListeners();
      }
    } catch (e) {
      // _emailResult = Statess.internet;
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print("error $e");
      notifyListeners();
    }
  }

  success() {
    _emailResult = Statess.Success;
    notifyListeners();
  }

  Future<bool> checkEmailExist(String email) async {
    try {
      _emailResult = Statess.Loading;
      notifyListeners();

      var url = Utils.checkEmailExistsURL;
      var body = {'email': email.trim()};
      var response = await http.post(Uri.parse(url), body: body);

      print(response.body);
      var status = jsonDecode(response.body);
      print("this is res... $status");

      if (status["status"] != false) {
        _emailResult = Statess.Success;
        passwordScreen();
        notifyListeners();
        print("trueeeeee");
        return true;
      } else {
        print("i am here false state");
        _emailResult = Statess.Failure;
        _loginErrorMsg = status["error"];
        _apiStatus = false;
        print("error $_loginErrorMsg");

        AppService.launchURLService(
            "https://www.thegiftguide.com/create-account/nsgauper@gmail.com");

        notifyListeners();
        print("falssssssse");
        return false;
      }
    } catch (e) {
      // Handle the no internet case here
      _emailResult = Statess.internet;
      _loginErrorMsg =
          "No internet connection"; // You can set a custom error message
      _apiStatus = false;

      Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize:
              16.0); // Return an empty container since the bottom sheet will be shown later

      print("error $_loginErrorMsg");
      notifyListeners();
      return false;
    }
  }

  int? _index;
  int? get index => _index;

  storeIndex(int index) async {
    _index = index;
    print("idex.......$_index");
    //  SharedPref sharedPref = SharedPref();
    await _sharedPref.saveInt("storedIndex", index);
  }

  String? _sharedData;
  String? get sharedData => _sharedData;

  bool resme = false;

  void handleAppLifecycleState(AppLifecycleState? state) async {
    if (state == AppLifecycleState.resumed) {
      resme = true;
      print("i am in resume state");
      await initSharing(); // Initialize shared data
      await isUserLogedIn(); // Check user login status
      print("_shareDataValue$_sharedData");
      notifyListeners();
    }
  }

  Future<void> initSharing() async {
    final initialText = await ReceiveSharingIntent.getInitialText();
    _sharedData = initialText ?? '';
    print("Shared data on app start: $_sharedData....$_username");
    notifyListeners();
    if (_sharedData!.isNotEmpty) {
      if (_username == null || _username == "") {
        _loggedInStatus = States.oopsLoginReq;
        notifyListeners();
      } else {
        _loggedInStatus = States.webviewShare;
        notifyListeners();
      }
    }

    ReceiveSharingIntent.getTextStream().listen((String value) {
      _sharedData = value ?? '';
      print("New shared data: $_sharedData..........$_username");
      if (_sharedData!.isNotEmpty) {
        if (_username == null || _username == "") {
          _loggedInStatus = States.oopsLoginReq;
          notifyListeners();
        } else {
          _loggedInStatus = States.webviewShare;
          notifyListeners();
        }
        notifyListeners();
      }
    });
  }

  Future<void> isUserLogedIn() async {
    print("this is authUser $_sharedData");

    await Future.delayed(Duration(seconds: 2));
//     if(resme==false){
// await initSharingK();
//     }else{

    print("resummmmme");
    initSharing();
    // }

    print("Data.......$_sharedData");
    final authUser = await _sharedPref.read("authUser");
    print("this is authUser $authUser");

    if (authUser == null) {
      if (_sharedData == '' || _sharedData == null) {
        print("popUP");
        _loggedInStatus = States.NotLoggedIn;

        notifyListeners();
      } else {
        print("logout");
        _loggedInStatus = States.oopsLoginReq;
      }
      notifyListeners();
    } else {
      _index = await _sharedPref.readInt("storedIndex") ?? 0;
      print("Stored index: $_index");
      var decode = jsonDecode(authUser);
      _token = decode["data"]["token"];
      _username = decode["data"]["user"]["username"];
      _avatar = decode["data"]["user"]["avatar"];

      print("this is username..............$_username");

      print("this is my tokken value ...$_avatar");

      // Check if there are other accounts in the database
      _accounts = await DatabaseHelper.instance.getAccounts();
      print("darrararrararararararara$_accounts");

      if (_accounts.isEmpty) {
        // No other accounts found, set the current account as the only logged-in account.
        _email = decode["data"]["email"];
        print("this is my email$_email");
        _loggedInStatus = States.LoggedIn;
        notifyListeners();
      } else {
        Map<String, dynamic> selectedAccount = _accounts[_index!];
        _email = selectedAccount['email'];
        _token = selectedAccount['token'];
        _username = selectedAccount['username'];
        _avatar = selectedAccount['avatar'];

        print("Switching to account: $_email.......$_token");

        if (_sharedData == '' || _sharedData == null) {
          print("i am hrrrrrr");
          _loggedInStatus = States.LoggedIn;
          notifyListeners();
        } else {
          print("this webview $_sharedData");
          _loggedInStatus = States.webviewShare;
          notifyListeners();
        }

        notifyListeners();
      }
    }
  }

  Future<void> logout() async {
    // Clear the shared preferences or any other session data you have
    await _sharedPref.remove("authUser");
    await _sharedPref.remove("storedIndex");

    // Remove the account from the database
    await DatabaseHelper.instance.deleteAccount(_email!, _username!, _token!);

    // Reset the email and token to empty values
    _email = '';
    _token = '';
    _username = '';
    _index = 0;
    _sharedData = '';

    // Update the state to NotLoggedIn
    _loggedInStatus = States.NotLoggedIn;
    notifyListeners();
  }

  loginScreen() {
    _sharedData = '';
    _loggedInStatus = States.NotLoggedIn;
    notifyListeners();
  }

  onloginScreen() {
    _sharedData = '';
    _loggedInStatus = States.login;
    notifyListeners();
  }

  onboardScreen() {
    _loggedInStatus = States.NotLoggedIn;
    notifyListeners();
  }

  HomeScreen() {
    _loggedInStatus = States.LoggedIn;
    notifyListeners();
  }

  ScrappingScreen() {
    _loggedInStatus = States.Scrapping;
    notifyListeners();
  }

  String? _URL;
  String? get URL => _URL;
  StoreUrlScreen(String search) {
    if (search.startsWith('https')) {
      _URL = search;
    } else {
      if (search == "zara" ||
          search == "catbirdnyc" ||
          search == "freepeople" ||
          search == "lovevery" ||
          search == "rei" ||
          search == "hannaandersson" ||
          search == "westelm" ||
          search == "westelm" ||
          search == "glassybaby" ||
          search == "rhoback" ||
          search == "volcom" ||
          search == "vuoriclothing" ||
          search == "zoechicco" ||
          search == "bombas" ||
          search == "bombas") {
        _URL = 'https://' + search + '.com/';
      } else {
        print("else");
        _URL = "https://www.google.com/search?q=" + search;
      }
    }
    // _URL =search;
    notifyListeners();
  }

  String? _email;
  String? get email => _email;

  emailStore(String emailData) {
    if (emailData != "") {
      _email = emailData;
    } else {
      _email = "No email";
    }
    // _loggedInStatus = States.NotLoggedIn;

    notifyListeners();
  }

  storeForCont() {
    if (textEditingController.text.isNotEmpty) {
      print("print coasasasnt value ...... ${textEditingController.text}");

      _email = textEditingController.text.toString();
      notifyListeners();
    }
  }

  passwordScreen() {
    _loggedInStatus = States.passwordScreen;
    notifyListeners();
  }

  MenuScreen() {
    _loggedInStatus = States.menu;
    notifyListeners();
  }

  homeScreen() {
    _loggedInStatus = States.LoggedIn;
    notifyListeners();
  }
}
