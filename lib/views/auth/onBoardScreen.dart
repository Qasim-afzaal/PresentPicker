import 'dart:io';

import 'package:flutter/material.dart';
import 'package:present_picker/provider/authProvider.dart';
import 'package:provider/provider.dart';

import '../../service/app_service.dart';
import '../../utils/Utils.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  AuthProvider? authProvider;
  @override
  void initState() {
  
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    super.initState();
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the app?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: const Text("NO"),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: const Text("YES"),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  void loginScreen() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider!.onloginScreen();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
          
          body: Column(
      

        children: [
          Expanded(
              // flex: ,
              child: Container()),
          //  SizedBox(height: 30),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  H1(text: 'Present Picker'),
                  SizedBox(height: 27),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: P1(
                        text:
                            'Welcome to Present Picker mobile app! With this app you can add to your wish list on Present Picker with 1 click from your phone or tablet.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 38, 0, 8),
                    child: Container(
                      width: 250,
                      child: B1(
                        title: 'SIGN IN | SIGN UP',
                        onPressed: () {
                          loginScreen();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: B3(
              onPressed: () {
                AppService.launchURLService(
                    "https://www.presentPicker.com/my-dashboard");
              },
              title: 'Learn more about Present Picker',
            ),
          ),
          SizedBox(
            height: Platform.isAndroid ? 10 : 10,
            // Your child widget goes here
          )
        ],
      )),
    );
  }
}
