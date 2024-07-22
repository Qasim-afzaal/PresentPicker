// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:present_picker/views/auth/widgets/password_field.dart';
import 'package:provider/provider.dart';


import '../../../provider/authProvider.dart';
import '../../../service/app_service.dart';
import '../../../utils/Utils.dart';

class PassWordScreen extends StatefulWidget {
  PassWordScreen({super.key});

  @override
  State<PassWordScreen> createState() => _PassWordScreenState();
}

class _PassWordScreenState extends State<PassWordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController _textEditingController = TextEditingController();

  bool isLoading = false;
  bool _obscureText = true;
  bool passwordCorrect = true;
  AuthProvider? authProvider;
  bool fieldColor = false;
  bool buttonLoding = false;

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
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(child: LayoutBuilder(
              builder: ((context, constraints) {
                double screenWidth = constraints.maxWidth.isFinite
                    ? constraints.maxWidth
                    : MediaQuery.of(context).size.width;
                print("screen width $screenWidth");
                return Column(
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
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                H2(text: 'Sign In'),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                P1(
                                    text:
                                        'Welcome back to Present Picker! Sign in with\n your password below to get started.'),
                              ],
                            ),

                            //SvgPicture.asset("assets/error.svg"),
                            // SizedBox(height: screenHeight * 0.02),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const P2(text: 'Email'),
                                  Container(
                                    padding: const EdgeInsets.all(0.0),
                                    height: 30.0,
                                    child: IconButton(
                                        onPressed: () {
                                          authProvider!.onloginScreen();

                                          // showInformationDialog(context);
                                          print("datataa");
                                        },
                                        icon: SvgPicture.asset(
                                            "assets/images/edit (2).svg")),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 17),
                              child: P1(text: "${authProvider!.email!}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  P2(text: '*Password'),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: PasswordField(
                                onChanged: (value) {
                                  setState(() {
                                    fieldColor = false;
                                  });
                                },
                                textAlign: TextAlign.start,
                                obscureText: _obscureText,
                                controller: passwordController,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter password";
                                  } else if (!passwordCorrect) {
                                    return "Incorrect password";
                                  } else if (fieldColor == true) {
                                    return screenWidth < 600
                                        ? "Wrong password. Try again or click forgot password"
                                        : "";
                                  }
                                  return null;
                                },
                                decoration: UiField(
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: _obscureText
                                            ? SvgPicture.asset(
                                                "assets/images/PswdView (1).svg",
                                                // height: 15,
                                                // width: 15,
                                              )
                                            // Image.asset("assets/images/Hide Password- black",height: 25, width: 25,)
                                            :
                                            // Image.asset("assets/images/Show",height: 25, width: 25,)

                                            SvgPicture.asset(
                                                "assets/images/hidePswd.svg",
                                                // height: 19,
                                                // width: 19,
                                              )),
                                    isFromPassword: true),
                              ),
                            ),

                            // SizedBox(height: 10),

                            screenWidth < 600
                                ? Consumer<AuthProvider>(
                                    builder: (context, auth, child) {
                                      if (auth.emailResult == Statess.Failure) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.fromLTRB(20, 0, 8, 0),
                                            //   child: Text(
                                            //     "Wrong password. Try again or click forgot password ",
                                            //     style: TextStyle(
                                            //         color: Color(0xffFF0000),
                                            //         fontSize: 12),
                                            //   ),
                                            // ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 8, 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      "below to reset it. If the issue persists, ",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffFF0000),
                                                          fontSize: 12)),
                                                  GestureDetector(
                                                    onTap: () {
                                                      try {
                                                        AppService.launchEmailApp(
                                                            "help@presentPicker.com");
                                                      } catch (e) {
                                                        // ScaffoldMessenger.of(context).showSnackBar(
                                                        //     SnackBar(content: Text(e.toString())));
                                                      }
                                                    },
                                                    child: Text(
                                                      "contact us.",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffFF0000),
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        );
                                      }
                                      {
                                        return Container();
                                      }
                                    },
                                  )
                                : Consumer<AuthProvider>(
                                    builder: (context, auth, child) {
                                      if (auth.emailResult == Statess.Failure) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 8, 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      "Wrong password. Try again or click forgot password below to reset it. If the issue persists, ",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffFF0000),
                                                          fontSize: 12)),
                                                  GestureDetector(
                                                    onTap: () {
                                                      try {
                                                        AppService.launchEmailApp(
                                                            "help@presentPicker.com");
                                                      } catch (e) {
                                                        // ScaffoldMessenger.of(context).showSnackBar(
                                                        //     SnackBar(content: Text(e.toString())));
                                                      }
                                                    },
                                                    child: Text(
                                                      "contact us.",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffFF0000),
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        );
                                      }
                                      {
                                        return Container();
                                      }
                                    },
                                  ),

                            Consumer<AuthProvider>(
                              builder: (context, auth, child) {
                                print(auth.emailResult);
                                if (auth.emailResult == Statess.Loading) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 15, 20, 0),
                                        child: SizedBox(
                                          // width: screenWidth * 0.9,
                                          // height: screenHeight * 0.06,
                                          child: B1(
                                            title: "NEXT",
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: SizedBox(
                                          // width: screenWidth * 0.95,
                                          child: B3(
                                            title: 'Forgot password?',
                                            onPressed: () {
                                              try {
                                                AppService.launchURLService(
                                                    "https://www.presentPicker.com/forgot-password");
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            e.toString())));
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Center(child: CircularProgressIndicator())
                                    ],
                                  );
                                }
                                {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 15, 20, 0),
                                        child: SizedBox(
                                          // width: screenWidth * 0.9,
                                          // height: screenHeight * 0.06,
                                          child: B1(
                                            title: 'NEXT',
                                            onPressed: fieldColor == true
                                                ? null
                                                : () async {
                                                    authProvider!.success();
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      await authProvider!
                                                          .onLogin(
                                                              passwordController
                                                                  .text);
                                                      if (authProvider!
                                                              .apiStatusPass ==
                                                          false) {
                                                        setState(() {
                                                          fieldColor = true;
                                                          formKey.currentState!
                                                              .validate();
                                                          buttonLoding = true;
                                                        });
                                                      }
                                                    }

                                                    setState(() {
                                                      passwordCorrect = true;
                                                    });
                                                  },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: SizedBox(
                                          // width: screenWidth * 0.95,
                                          child: B3(
                                            title: 'Forgot password?',
                                            onPressed: () {
                                              try {
                                                AppService.launchURLService(
                                                    "https://www.presentPicker.com/forgot-password");
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            e.toString())));
                                              }
                                            },
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
                    ),
                  ],
                );
              }),
            )),
          ),
        ),
      ),
    );
  }
}
