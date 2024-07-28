// import 'package:flutter/material.dart';
// import 'package:the_gift_guide/base/app_view.dart';
// import 'package:the_gift_guide/views/auth/login_signup_view.dart';
// import 'package:the_gift_guide/views/auth/password_screen.dart';
// import 'package:the_gift_guide/views/splash/splash_view.dart';
// import 'package:the_gift_guide/views/auth/email_view.dart';
// import '../../views/home/home_view.dart';

// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppView.id:
//         return MaterialPageRoute(
//           builder: (_) => const AppView(),
//           settings: const RouteSettings(name: "AppView"),
//         );
//       case SplashView.id:
//         return MaterialPageRoute(builder: (_) => const SplashView());
//       case PasswordView.id:
//         PasswordViewArguments arguments = settings.arguments as PasswordViewArguments;
//         return MaterialPageRoute(builder: (_) => PasswordView(arguments: arguments));
//       case EmailView.id:
//         EmailViewArguments arguments = settings.arguments as EmailViewArguments;
//         return MaterialPageRoute(builder: (_) => EmailView(arguments: arguments));
//       case LoginOrSignUpView.id:
//         return MaterialPageRoute(builder: (_) => LoginOrSignUpView());
//       case HomeView.id:
//         return MaterialPageRoute(
//           builder: (_) => const HomeView(),
//           settings: const RouteSettings(
//             name: "HomeView",
//           ),
//         );

//       default:
//         return MaterialPageRoute(
//           builder: (_) {
//             return const Scaffold(
//               body: Center(
//                 child: Text("No Route Defined"),
//               ),
//             );
//           },
//         );
//     }
//   }
// }
