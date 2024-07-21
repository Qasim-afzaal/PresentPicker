import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../provider/scrapDataPreovider.dart';
import 'scrapData.dart';
import 'webView.dart';

class WebViewScreen extends StatefulWidget {
  // String url;
  // String value;
  // WebViewScreen({required this.url, required this.value});

  @override
  State<WebViewScreen> createState() => _WebViewScreenScreenState();
}

class _WebViewScreenScreenState extends State<WebViewScreen> {
  WebViewController? controller;
  String currentUrl = "";
  String Url = "";
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => AuthProvider()..isUserLogedIn()),
        ChangeNotifierProvider(create: (_) => ScrapView_Model()),
      ],
      child: Consumer<ScrapView_Model>(
        builder: (context, auth, child) {
          print("this is Status2 ${auth.webViewScreenStatus}");
          if (auth.webViewScreenStatus == WebViewStatus.webView) {
          
            return WebViewWebsite(
              
            );
          } else if (auth.webViewScreenStatus == WebViewStatus.scarpData) {
            return ScrapData();
          } else {
            print("NoScreen");
            return Container(
              color: Colors.amber,
              child: Text("data"),
            );
          }

        
        },
      ),
    );
  }
}
