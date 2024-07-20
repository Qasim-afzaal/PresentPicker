/// This screen is is just checking weather user want to login or signup
/// If user click on signing so it will take user into login screen
/// If user click on signup so it will take user into browser

import 'package:flutter/material.dart';
import 'package:present_picker/service/app_service.dart';
import 'package:present_picker/views/auth/widgets/login_signup_landscape_view.dart';
import 'package:present_picker/views/auth/widgets/login_signup_portrait_view.dart';


class LoginOrSignUpView extends StatelessWidget {
  static const String id = "/login-or-sign-up-view";
  LoginOrSignUpView({Key? key}) : super(key: key);

  final AppService appService = AppService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return const LoginOrSignUpPortraitView();
        } else {
          return const LoginOrSignUpLandscapeView();
        }
      }),
    );
  }
}
