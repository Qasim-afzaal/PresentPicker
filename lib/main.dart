// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:present_picker/main_auth.dart';
import 'package:present_picker/provider/authProvider.dart';
import 'package:present_picker/provider/scrapDataPreovider.dart';
import 'package:present_picker/views/auth/databaseHelperClass/db_class.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

GlobalKey<ScaffoldMessengerState>? rootScaffoldMessengerKey;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  await DatabaseHelper.instance.database;
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Widget storyBoardscreen = OnboardScreen();s

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Change this color to your desired color
      statusBarBrightness: Brightness.light, // Dark text for light background
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProvider()), // Provide AuthProvider
        ChangeNotifierProvider(create: (_) => ScrapView_Model()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.light(
            primary: Colors.black,
            secondary: Colors.black,
          ),                    
        ),
        home: ScreenHandleWithProvider(),
      ),
    );
  }
}
