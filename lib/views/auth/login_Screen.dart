// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:present_picker/views/auth/widgets/emailField2.dart';
import 'package:provider/provider.dart';
import '../../provider/authProvider.dart';
import '../../provider/scrapDataPreovider.dart';
import '../../service/app_service.dart';
import '../../utils/Utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _emailformkey = GlobalKey<FormState>();
  bool fieldColor = false;
  bool buttonLoding = false;
  AuthProvider? authProvider;
  void initState() {
    // TODO: implement initState
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    fieldColor = false;
    super.initState();
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Change this color to your desired color
      statusBarBrightness: Brightness.light, // Dark text for light background
    ));
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        // appBar: AppBar(title: Text("Login"),),
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: Platform.isAndroid
                        ? EdgeInsets.fromLTRB(0, 10, 15, 0)
                        : EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: GestureDetector(
                        onTap: () {
                          authProvider!.onboardScreen();
                        },
                        child: SvgPicture.asset("assets/images/Cross.svg")),

                    // Image.asset("assets/images/Close.png",
                    //     height: 15, width: 15)),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            H2(text: 'Welcome To\nPresent Picker'),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 17.0),
                              child:
                                  P1(text: 'Enter your email to get started'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 2),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: P2(text: '*Email')),
                        ),
                        Form(
                          key: _emailformkey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: EmailField2(
                              onChanged: (value) {
                                setState(() {
                                  fieldColor = false;
                                });
                              },
                              apicall: fieldColor,
                              textAlign: TextAlign.start,
                              controller: emailController,
                              validator: (String? value) {
                                String p =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(p);
                                if (value == null || value.isEmpty) {
                                  return "Please enter email address";
                                } else if (!regExp.hasMatch(value.trim())) {
                                  return "Please enter valid email address";
                                }
                                //  else if (fieldColor == true) {
                                //   return "Please enter valid email address";
                                // }
                                return null;
                              },
                              decoration: const UiField(),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            print(auth.emailResult);
                            if (auth.emailResult == Statess.Loading) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 0),
                                      child: B1(
                                        onPressed: () {
                                          // buttonLoding==true;
                                        },
                                        title: 'NEXT',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = null,
                                        text:
                                            'By clicking "next", you agree to our privacy policy and terms',
                                        style: Utils.b3TextStyleWithUnderLine,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Center(child: CircularProgressIndicator()),
                                ],
                              );
                            }
                            {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: SizedBox(
                                      // width: screenWidth * 0.9,
                                      // height: screenHeight * 0.06,
                                      child: B1(
                                        title: 'NEXT',
                                        onPressed: () async {
                                          setState(() {
                                            fieldColor = false;
                                          });

                                          if (_emailformkey.currentState!
                                              .validate()) {
                                            var res = await authProvider!
                                                .checkEmailExist(
                                                    emailController.text);
                                            print("value of ress$res");
                                            if (res == false) {
                                              setState(() {
                                                print("res value update");
                                              });
                                            }
                                            authProvider!.emailStore(
                                                emailController.text);
                                            print(
                                                "............${authProvider!.apiStatus}");
                                            if (authProvider!.apiStatus ==
                                                false) {
                                              setState(() {
                                                fieldColor = true;
                                                _emailformkey.currentState!
                                                    .validate();
                                                buttonLoding = true;
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            try {
                                              AppService.launchURLService(
                                                  "https://www.presentPicker.com/terms");
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(e.toString()),
                                                ),
                                              );
                                            }
                                          },
                                        text:
                                            'By clicking "next", you agree to our privacy policy and terms',
                                        style: Utils.b3TextStyleWithUnderLine,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
