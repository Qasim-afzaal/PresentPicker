import 'package:flutter/material.dart';
import 'package:present_picker/utils/Utils.dart';

import '../../../service/app_service.dart';
import '../email_view.dart';

class LoginOrSignUpLandscapeView extends StatelessWidget {
  const LoginOrSignUpLandscapeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        SizedBox(height: screenHeight * 0.1),
   
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            H1(text: 'Present Picker'),
            SizedBox(height: screenHeight * 0.03),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: P1(
                  text:
                      'Welcome to Present Picker mobile app!\n With this app you can add to your wish list on The Gift\nGuide with 1 click from your phone or tablet.'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: SizedBox(
                width: screenWidth * 0.4,
                height: screenHeight * 0.1,
                child: B1(
                  title: 'SIGN IN | SIGN UP',
                  onPressed: () => Navigator.pushNamed(
                    context,
                    EmailView.id,
                    arguments: EmailViewArguments(emailViewType: EmailViewType.login),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            B3(
              onPressed: () => AppService.launchURLService('https://www.presentPicker.com'),
              title: 'Learn more about Present Picker',
            ),
            SizedBox(height: screenHeight * 0.2),
          ],
        ),
     
      ],
    );
  }
}
