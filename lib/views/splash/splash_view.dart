
import 'package:flutter/material.dart';
import 'package:present_picker/styles/app_color.dart';
import 'package:present_picker/utils/Utils.dart';


class SplashView extends StatefulWidget {
  // static const String id = "/splash-view";
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                height: 155,
                width: 155,
                child: Image.asset("assets/images/App_Logo_Thicker.png",
                    height: 155, width: 155, fit: BoxFit.cover),
              ),
            ),
            H1(text: 'Present Picker'),
            const Text(
              'Ensuring delighted faces on special occasions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                height: 0,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w400,
                color: Color(0xff000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
