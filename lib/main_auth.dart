
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:the_gift_guide/base/app_view.dart';
// import 'package:the_gift_guide/route_generator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:the_gift_guide/provider/authProvider.dart';

import 'package:the_gift_guide/provider/scrapDataPreovider.dart';
import 'package:the_gift_guide/views/WebViewScreens/webScrapping_List.dart';

import 'package:the_gift_guide/views/WebViewScreens/webView_Screen.dart';
import 'package:the_gift_guide/views/auth/login_Screen.dart';
import 'package:the_gift_guide/views/auth/onBoardScreen.dart';
import 'package:the_gift_guide/views/auth/signUp_Screen.dart';
import 'package:the_gift_guide/views/auth/widgets/pass_Screen.dart';
import 'package:the_gift_guide/views/data_entry_view/scrap_data_view.dart';
import 'package:the_gift_guide/views/home/home_view.dart';
import 'package:the_gift_guide/views/menuScreen/menu.dart';
import 'package:the_gift_guide/views/splash/splash_view.dart';
import 'package:the_gift_guide/views/wishlist/oops_login_req.dart';

class ScreenHandleWithProvider extends StatefulWidget {
  const ScreenHandleWithProvider({super.key});

  @override
  State<ScreenHandleWithProvider> createState() =>
      _ScreenHandleWithProviderState();
}

class _ScreenHandleWithProviderState extends State<ScreenHandleWithProvider> with WidgetsBindingObserver{
  
  
late AuthProvider authProvider; // Declare the AuthProvider variable

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false); // Initialize the AuthProvider

    WidgetsBinding.instance?.addObserver(this); // Add this widget as an observer for lifecycle events
// authProvider.initSharing();
    // authProvider.handleAppLifecycleState(
    //   WidgetsBinding.instance!.lifecycleState,
    // );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this); // Remove this widget as an observer
     authProvider.dispose();
    super.dispose();
  }

@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
        print(" i am in oriny");
    if (state == AppLifecycleState.resumed) {
      print("this is app resume state");
      authProvider.initSharing();
      authProvider.handleAppLifecycleState(state);
    }
  }
  
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        
        ChangeNotifierProvider(create: (_) => AuthProvider()
            ..isUserLogedIn()
            ),
            
        ChangeNotifierProvider(create: (_) => ScrapView_Model()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          print(" Screen STATUS ${auth.loggedInStatus}");
          // return SplashView();
          //  auth.handleAppLifecycleState(
          //   WidgetsBinding.instance!.lifecycleState,
          // );

          if (auth.loggedInStatus == States.Authenticating) {
            return SplashView();

          } else if (auth.loggedInStatus == States.NotLoggedIn) {
            return OnboardScreen();
          } else if (auth.loggedInStatus == States.SingUPScreen) {
            return SignUpScreen();
          } else if (auth.loggedInStatus == States.LoggedIn) {
            return HomeView();
          } else if (auth.loggedInStatus == States.passwordScreen) {
            return PassWordScreen();
          }else if (auth.loggedInStatus == States.Scrapping) {
            return WebViewScreen();
          }else if (auth.loggedInStatus == States.menu) {
            return MenuView();
          }
          else if (auth.loggedInStatus == States.webviewShare) {
            return WebViewWebShare();
          }
           else if (auth.loggedInStatus == States.oopsLoginReq) {
            return OOPs();
          }
          else if (auth.loggedInStatus == States.login) {
            return LoginScreen();
          }
          else{
            return OnboardScreen();
          }
        }
      ),
    );
  }
}
