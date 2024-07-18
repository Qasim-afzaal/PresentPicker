/// This is welcome screen where we take user email to check weather user exist or not in database
///
/// If user exist in database it will direct to login screen
///
/// If user doesn't exist it will launch Url and direct user to website to create account

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:present_picker/service/app_service.dart';
import 'package:present_picker/service/auth_service.dart';
import 'package:present_picker/utils/Utils.dart';
import 'package:present_picker/views/auth/password_screen.dart';
import 'package:present_picker/views/auth/widgets/email_field.dart';

enum EmailViewType { login, scraping }

class EmailViewArguments {
  final EmailViewType emailViewType;

  EmailViewArguments({required this.emailViewType});
}

class EmailView extends StatefulWidget {
  static const String id = "/email-view";
  final EmailViewType emailViewType;

  EmailView({
    super.key,
    required EmailViewArguments arguments,
  }) : emailViewType = arguments.emailViewType;

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final TextEditingController emailController = TextEditingController();
  final AuthService authService = AuthService();
  final AppService appService = AppService();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Form(
            key: formKey,
            child: Center(
              child: SizedBox(
                width: screenWidth * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        H2(text: 'Welcome To\nPresent Picker'),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 18.0),
                          child: P1(text: 'Enter your email to get started'),
                        ),
                      ],
                    ),
                    const Align(alignment: Alignment.centerLeft, child: P2(text: 'Email')),
                    EmailField(
                      textAlign: TextAlign.start,
                      controller: emailController,
                      validator: (String? value) {
                        String p =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(p);
                        if (value == null || value.isEmpty) {
                          return "Please enter an email";
                        } else if (!regExp.hasMatch(value.trim())) {
                          return "Please enter valid email address";
                        }
                        return null;
                      },
                      decoration: const UiField(),
                    ),
                    const SizedBox(height: 8),
                    !isLoading
                        ? SizedBox(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.06,
                            child: B1(
                              title: 'NEXT',
                              onPressed: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  try {
                                    setState(() => isLoading = true);
                                    bool isEmailExisting = await authService.checkEmailExist(emailController.text.trim());

                                    if (isEmailExisting) {
                                      if (mounted) {
                                        setState(() => isLoading = false);
                                        Navigator.pushNamed(
                                          context,
                                          PasswordView.id,
                                          arguments: PasswordViewArguments(
                                            email: emailController.text.trim(),
                                            passwordViewType:
                                                widget.emailViewType == EmailViewType.login ? PasswordViewType.login : PasswordViewType.scraping,
                                          ),
                                        );
                                      }
                                    } else {
                                      setState(() => isLoading = false);
                                      AppService.launchURLService("ount?username=${emailController.text}");
                                    }
                                  } catch (e) {
                                    setState(() => isLoading = false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                }
                              },
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            try {
                              AppService.launchURLService("");
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          },
                        text: 'By clicking "next", you agree to our privacy policy and terms',
                        style: Utils.b3TextStyleWithUnderLine,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
          );
      
        } else {
          return ListView(
            children: [
              Form(
                key: formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.08),
                      const H2(text: 'Welcome To The Gift Guide'),
                      SizedBox(height: screenHeight * 0.03),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 18.0),
                        child: P1(text: 'Enter your email to get started'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          //width: screenWidth * 0.45,
                          child: Column(
                            children: [
                              Align(alignment: Alignment.centerLeft, child: TextFieldLabel(text: 'Email')),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (String? value) {
                                    String p =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regExp = RegExp(p);
                                    if (value == null || value.isEmpty) {
                                      return "Please enter an email";
                                    } else if (!regExp.hasMatch(value)) {
                                      return "Please enter valid email address";
                                    }
                                    return null;
                                  },
                                  decoration: const UiField(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      !isLoading
                          ? SizedBox(
                              width: screenWidth * 0.45,
                              height: screenHeight * 0.1,
                              child: B1(
                                title: 'NEXT',
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ?? false) {
                                    try {
                                      setState(() => isLoading = true);
                                      bool isEmailExisting = await authService.checkEmailExist(emailController.text);

                                      if (isEmailExisting) {
                                        if (mounted) {
                                          setState(() => isLoading = false);
                                          Navigator.pushNamed(
                                            context,
                                            PasswordView.id,
                                            arguments: PasswordViewArguments(
                                              email: emailController.text,
                                              passwordViewType:
                                                  widget.emailViewType == EmailViewType.login ? PasswordViewType.login : PasswordViewType.scraping,
                                            ),
                                          );
                                        }
                                      } else {
                                        setState(() => isLoading = false);
                                        AppService.launchURLService("https://www.thegiftguide.com/create-account?username=${emailController.text}");
                                      }
                                    } catch (e) {
                                      setState(() => isLoading = false);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  }
                                },
                              ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                      SizedBox(
                        child: RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                try {
                                  AppService.launchURLService("https://www.thegiftguide.com/terms");
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              },
                            text: 'By clicking "next", you agree to our privacy policy and terms',
                            style: Utils.b3TextStyleWithUnderLine,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
