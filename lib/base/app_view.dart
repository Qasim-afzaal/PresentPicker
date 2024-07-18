import 'dart:async';
import 'package:flutter/material.dart';
import 'package:present_picker/model/scrapping_model.dart';
import 'package:present_picker/service/app_service.dart';
import 'package:present_picker/utils/Utils.dart';
import 'package:present_picker/views/data_entry_view/scrap_data_view.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

import '../service/local_db_service.dart';
import '../views/auth/email_view.dart';
import '../views/home/home_view.dart';
import '../views/splash/splash_view.dart';

class AppView extends StatefulWidget {
  static const String id = "/app-view";

  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  AppService appService = AppService();

  StreamSubscription? _intentDataStreamSubscription;
  ScrappingModel? scrappingModelIns;
  bool isReady = false;
  bool isScrapping = false;
  bool comingFromShare = false;

  String email = '';

  void getEmail() async {
    email = await LocalDbService.retrieveEmail;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getEmail(); // Get email from local storage
    _intentDataStreamSubscription = ReceiveSharingIntent.getTextStream().listen(
      (String value) async {
        if (mounted) {
          String url = appService.matchAndCreateURL(value);
          if (await LocalDbService.retrieveEmail != '') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScrapDataView(
                  url: appService.matchAndCreateURL(url),
                ),
                settings: const RouteSettings(
                  name: "ScrapeView",
                ),
              ),
            );
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginBottomSheet()));
            // Navigator.pushNamed(context, LoginOrSignUpView.id);
            //
            // showModalBottomSheet(
            //     context: context,
            //     builder: (context) => const LoginBottomSheet());
          }
        }
      },
      onError: (err) {
        // print("getLinkStream error: $err");
      },
    );

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) async {
      if (value != null) {
        String url = appService.matchAndCreateURL(value);
        if (await LocalDbService.retrieveEmail != '') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScrapDataView(
                url: appService.matchAndCreateURL(url),
              ),
              settings: const RouteSettings(
                name: "ScrapeView",
              ),
            ),
          );
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginBottomSheet()));
          //   Navigator.pushNamed(context, LoginOrSignUpView.id);
          //   showModalBottomSheet(
          //       context: context, builder: (context) => const LoginBottomSheet());
        }
      }
    });
  }

  @override
  void dispose() async {
    if (_intentDataStreamSubscription != null) {
      await _intentDataStreamSubscription!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
,
      // )
      body: FutureBuilder<String?>(
        future: ReceiveSharingIntent.getInitialText(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ScrapDataView(url: appService.matchAndCreateURL(snapshot.data!));
            }
          }

          if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
            return const SplashView();
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, HomeView.id),
                icon: const Icon(Icons.close),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                  Center(
                    child: Container(margin: const EdgeInsets.symmetric(horizontal: 30), child: const H2(text: 'Oops, you need to log in for that')),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Center(
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          child: const P1(text: 'In order to use that feature, you need to log in or create an account')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 60, right: 60),
                    child: B1(
                      title: 'LOG IN | CREATE ACCOUNT',
                      onPressed: () => Navigator.pushNamed(context, EmailView.id, arguments: EmailViewArguments(emailViewType: EmailViewType.login)),
                    ),
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}