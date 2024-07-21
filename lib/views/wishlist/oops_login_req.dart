
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:present_picker/utils/Utils.dart';
import 'package:provider/provider.dart';

import '../../provider/authProvider.dart';
import '../../styles/app_color.dart';

class OOPs extends StatefulWidget {
  @override
  State<OOPs> createState() => _OOPsState();
}

class _OOPsState extends State<OOPs> {
  AuthProvider? authProvider;
  TextEditingController searchController = TextEditingController();
  bool dropdown = false;
  InAppWebViewController? _webViewController;
  // String? Url;

  void initState() {

    authProvider = Provider.of<AuthProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        centerTitle: true,
        title: H1sss(text: "Present Picker"),
        backgroundColor: Colors.black,
        elevation: 0.4,
      ),
      backgroundColor: AppColors.homeBackground,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse("${authProvider!.sharedData.toString()}")),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    cacheEnabled: false,
                    useOnDownloadStart: true,
                    javaScriptEnabled: true,
                  ),
                ),
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                  _webViewController!.addJavaScriptHandler(
                      handlerName: 'handlerFoo',
                      callback: (args) {
                        // return data to JavaScript side!
                        return {'bar': 'bar_value', 'baz': 'baz_value'};
                      });

                  _webViewController!.addJavaScriptHandler(
                      handlerName: 'handlerFooWithArgs',
                      callback: (args) {
                        print(args);
                        // it will print: [1, true, [bar, 5], {foo: baz}, {bar: bar_value, baz: baz_value}]
                      });
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final url = navigationAction.request.url.toString();
                  setState(() {
                    // authProvider!.sharedData.to = url;
                    // print("jalkhsalhsa$Url");
                  });
                  return NavigationActionPolicy
                      .ALLOW; // Allow the webview to load the URL
                },
                onLoadStart: (controller, url) {
                  controller.getUrl().then((currentUrl) {
                    setState(() {});
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {},
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                  // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
                },
                onLoadStop: (controller, url) async {
                  print("event call");
                },
                onLoadError: (controller, url, code, message) {
                  print("this is $controller....$code......$message");
                },
              ),

              // if (dropdown == true)
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      // dropdown = false;
                    });
                  },
                  child: Container(
                      height: MediaQuery.of(context)
                          .size
                          .height, // Match parent height
                      width: MediaQuery.of(context)
                          .size
                          .width, // Match parent width
                      color: Colors.black
                          .withOpacity(0.7), // Semi-transparent black color
                      child: Container()),
                ),
              ),

              Positioned(
                  bottom:
                      0, // Set the top position value as per your requirement
                  right: 1,
                  child: Container(
                    color: Colors.white,
                    height: 275, // Adjust the height as needed
                    width: MediaQuery.sizeOf(context).width * 0.98,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 6,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    // Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                        "assets/images/Close.png",
                                        height: 15,
                                        width: 15),
                                  )),
                              const Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    H2sssss(
                                        text:
                                            "Oops, you need to log in\nfor that"),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: P1s(
                                          text:
                                              "In order to use that feature, you need to log in or create an account"),
                                    )
                                  ],
                                ),
                              ),

                              // Content of the bottom sheet

                              // Close button
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(60, 30, 60, 25),
                            child: B1(
                                title: "LOG IN | CREATE ACCOUNT",
                                onPressed: () {
                                  authProvider!.onloginScreen();
                                }),
                          ),
// SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ))
              // : Container(),
            ],
          );
        },
      ),
    );
  }
}
