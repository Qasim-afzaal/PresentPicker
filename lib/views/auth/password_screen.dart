import 'package:flutter/material.dart';
import 'package:present_picker/model/user.dart';
import 'package:present_picker/service/app_service.dart';
import 'package:present_picker/service/local_db_service.dart';
import 'package:present_picker/views/auth/widgets/password_field.dart';
import 'package:present_picker/views/home/home_view.dart';

import '../../service/auth_service.dart';
import '../../utils/Utils.dart';

enum PasswordViewType { login, scraping }

class PasswordViewArguments {
  final String email;
  final PasswordViewType passwordViewType;

  PasswordViewArguments({required this.email, required this.passwordViewType});
}

class PasswordView extends StatefulWidget {
  static const String id = "/password-view";
  final String email;
  final PasswordViewType passwordViewType;

  PasswordView({Key? key, required PasswordViewArguments arguments})
      : email = arguments.email,
        passwordViewType = arguments.passwordViewType,
        super(key: key);

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final AuthService authService = AuthService();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _obscureText = true;
  bool passwordCorrect = true;

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
                        H2(text: 'Sign In'),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        P1(text: 'Welcome back to Present Picker! Sign in with\n your password below to get started.'),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const P2(text: 'Email'),
                        InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.edit_outlined, size: 18)),
                      ],
                    ),
                    P1(text: widget.email),
                    PasswordField(
                      textAlign: TextAlign.start,
                      obscureText: _obscureText,
                      controller: passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        } else if (!passwordCorrect) {
                          return "Incorrect password";
                        }
                        return null;
                      },
                      decoration: UiField(
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined)),
                          isFromPassword: true),
                    ),
                    const SizedBox(height: 5),
                    !isLoading
                        ? SizedBox(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.06,
                            child: B1(
                              title: 'NEXT',
                              onPressed: () async {
                                setState(() {
                                  passwordCorrect = true;
                                });
                                if (formKey.currentState?.validate() ?? false) {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Login result = await authService.onLogin(email: widget.email, password: passwordController.text);
                                    bool isDataSaved = await LocalDbService.saveLoginStatus(result.data.token, widget.email, result.data.user);

                                    if (isDataSaved) {
                                      if (mounted) {
                                        setState(() => isLoading = false);
                                        if (widget.passwordViewType == PasswordViewType.login) {
                                          Navigator.pushNamed(context, HomeView.id);
                                        } else {
                                          Navigator.popUntil(context, (route) => route.settings.name == "ScrapeView");
                                        }
                                      }
                                    } else {
                                      setState(() => isLoading = false);
                                      if (mounted) {
                                        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error")));
                                      }
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                      passwordCorrect = false;
                                    });
                                    formKey.currentState?.validate();
                                  }
                                }
                              },
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 2),
                    SizedBox(
                      width: screenWidth * 0.95,
                      child: B3(
                        title: 'Forgot password?',
                        onPressed: () {
                          try {
                            AppService.launchURLService("https://www.presentPicker.com/forgot-password");
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        },
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.06),
                    const H2(text: 'Sign In'),
                    SizedBox(height: screenHeight * 0.04),
                    const P1(text: 'Welcome back to Present Picker! Sign in with\n your password below to get started.'),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: screenWidth * 0.45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFieldLabel(text: 'Email'),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.edit_outlined, size: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.45,
                      child: Align(alignment: Alignment.centerLeft, child: P1(text: widget.email)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: UiField(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  (_obscureText) ? _obscureText = false : _obscureText = true;
                                });
                              },
                              child: (_obscureText)
                                  ? const Icon(Icons.visibility_outlined, size: 25, color: Colors.black)
                                  : const Icon(Icons.visibility_off_outlined, size: 25, color: Colors.black),
                            ),

                            // suffixIcon: IconButton(
                            //   alignment: Alignment.bottomCenter,
                            //   padding: const EdgeInsets.only(bottom: 14, right: 3),
                            //   onPressed: () {
                            //     setState(() {
                            //       (_obscureText) ? _obscureText = false : _obscureText = true;
                            //     });
                            //   },
                            //   icon: (_obscureText)
                            //       ? const Icon(Icons.visibility_outlined, size: 18, color: Color(0xff919191))
                            //       : const Icon(Icons.visibility_off_outlined, size: 18, color: Color(0xff919191)),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    !isLoading
                        ? Container(
                            // width: screenWidth * 0.45,
                            // width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: screenHeight * 0.1,
                            child: B1(
                              title: 'NEXT',
                              onPressed: () async {
                                try {
                                  setState(() => isLoading = true);
                                  Login result = await authService.onLogin(email: widget.email, password: passwordController.text);
                                  bool isDataSaved = await LocalDbService.saveLoginStatus(result.data.token, widget.email, result.data.user);
                                  if (isDataSaved) {
                                    if (mounted) {
                                      setState(() => isLoading = false);
                                      if (widget.passwordViewType == PasswordViewType.login) {
                                        Navigator.pushNamed(context, HomeView.id);
                                      } else {
                                        Navigator.popUntil(context, (route) => route.settings.name == "ScrapeView");
                                      }
                                    }
                                  } else {
                                    setState(() => isLoading = false);
                                    if (mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error")));
                                    }
                                  }
                                } catch (e) {
                                  setState(() => isLoading = false);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                }
                              },
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 2),
                    B3(
                      title: 'Forgot password?',
                      onPressed: () {
                        try {
                          AppService.launchURLService("https://www.presentPicker.com/forgot-password");
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
