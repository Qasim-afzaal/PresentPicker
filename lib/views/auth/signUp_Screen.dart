import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:present_picker/provider/authProvider.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _emailformkey = GlobalKey<FormState>();
final FocusNode _focusNode = FocusNode();
  AuthProvider? authProvider;

  void initState() {
    // TODO: implement initState
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("asdjfadfhsafhdfa");
    return Container();
  //   return GestureDetector(
  //     onTap: () {
  //        FocusScope.of(context).requestFocus(new FocusNode());
  //     },
  //     child: Scaffold(
  //       body: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Center(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     H2(text: 'Welcome To\nPresent Picker'),
  //                   ],
  //                 ),
  //                 SizedBox(height: 20),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: const [
  //                     Padding(
  //                       padding: EdgeInsets.only(bottom: 18.0),
  //                       child: P1(text: 'Enter your email to get started'),
  //                     ),
  //                   ],
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
  //                   child: Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: P2(text: 'Email')),
  //                 ),
  //                 Form(
  //                   key: _emailformkey,
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 30),
  //                     child: EmailField(
  //                       focusNode: _focusNode,
  //                       textAlign: TextAlign.start,
  //                       controller: emailController,
  //                       validator: (String? value) {
  //                         String p =
  //                             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //                         RegExp regExp = RegExp(p);
  //                         if (value == null || value.isEmpty) {
  //                           return "Please enter an email";
  //                         } else if (!regExp.hasMatch(value.trim())) {
  //                           return "Please enter valid email address";
  //                         }
  //                         return null;
  //                       },
  //                       decoration: const UiField(),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
  //                   child: SizedBox(
  //                     // width: screenWidth * 0.9,
  //                     // height: screenHeight * 0.06,
  //                     child: B1(
  //                       title: 'NEXT',
  //                       onPressed: () async {
  //                         if (_emailformkey.currentState!.validate()) {
  //                           print("hola");
  //                           // authProvider!.passwordScreen();
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.fromLTRB(30, 6, 0, 0),
  //                   child: RichText(
  //                     text: TextSpan(
  //                       recognizer: TapGestureRecognizer()
  //                         ..onTap = () {
  //                           try {
  //                             AppService.launchURLService(
  //                                 "https://www.presentPicker.com/terms");
  //                           } catch (e) {
  //                             ScaffoldMessenger.of(context).showSnackBar(
  //                               SnackBar(
  //                                 content: Text(e.toString()),
  //                               ),
  //                             );
  //                           }
  //                         },
  //                       text:
  //                           'By clicking "next", you agree to our privacy policy and terms',
  //                       style: Utils.b3TextStyleWithUnderLine,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
}