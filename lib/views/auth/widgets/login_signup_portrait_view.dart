import 'package:flutter/material.dart';

import '../../../service/app_service.dart';
import '../../../utils/Utils.dart';
import '../email_view.dart';

class LoginOrSignUpPortraitView extends StatelessWidget {
  const LoginOrSignUpPortraitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthVariable = MediaQuery.of(context).size.width;
    final double heightVariable = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          H1(text: 'Present Picker'),
          SizedBox(height: heightVariable * 0.034),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: P1(
              text:
                  'Welcome to Present Picker mobile app! With this app you can add to your wish list on Present Picker with 1 click from your phone or tablet.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 17),
            child: SizedBox(
              width: widthVariable * 0.8,
              height: heightVariable * 0.055,
              child: B1(
                title: 'SIGN IN | SIGN UP',
                onPressed: () => Navigator.pushNamed(context, EmailView.id, arguments: EmailViewArguments(emailViewType: EmailViewType.login)),
              ),
            ),
          ),
          SizedBox(height: heightVariable * 0.32),
          B3(
            onPressed: () => AppService.launchURLService('https://www.presentPicker.com'),
            title: 'Learn more about Present Picker',
          ),
          SizedBox(height: heightVariable * 0.034),
        ],
      ),
    );
  }
}
