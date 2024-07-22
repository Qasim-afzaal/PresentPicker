// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:present_picker/service/app_service.dart';
import 'package:present_picker/utils/Utils.dart';
import 'package:provider/provider.dart';

import '../../provider/authProvider.dart';
import '../../provider/scrapDataPreovider.dart';
import '../../styles/app_color.dart';

enum Options { search, upload, copy, exit }

class HomeView extends StatefulWidget {
  static const String id = "/home-view";

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AuthProvider? authProvider;
  ScrapView_Model? scrapView_Model;
  TextEditingController searchController = TextEditingController();
  final MethodChannel _methodChannel =
      MethodChannel('com.example.the_gift_guide/deeplink');
  var _popupMenuItemIndex = 0;
  Color _changeColorAccordingToMenuItem = Colors.red;
  var appBarHeight = AppBar().preferredSize.height;
  String sharedData = '';
  int maxUsernameLength = 0;
  bool dropdown = false;

  void initState() {
    // TODO: implement initState
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    scrapView_Model = Provider.of<ScrapView_Model>(context, listen: false);
    dropdown = false;
    for (var accountInfo in authProvider!.account) {
      String username = accountInfo["username"].toString();
      int usernameLength = username.length;
      if (usernameLength > maxUsernameLength) {
        maxUsernameLength = usernameLength;
      }
    }

    super.initState();
  }

  logoutfun() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider!.logout();
  }

  List<String> imageFileNames = [
    "Amazon.png",
    "Nordstrom.png",
    "Anthropologie.png",
    "target.png",
    "Lululemon.png",
    "Neiman_Marcus.png",
    "Sephora.png",
    "HomeDepot.png",
    "saks_fifth _avenue.png",

    // Add more image file names as needed
  ];

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == Options.search.index) {
      _changeColorAccordingToMenuItem = Colors.red;
    } else if (value == Options.upload.index) {
      _changeColorAccordingToMenuItem = Colors.green;
    } else if (value == Options.copy.index) {
      _changeColorAccordingToMenuItem = Colors.blue;
    } else {
      _changeColorAccordingToMenuItem = Colors.purple;
    }
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // removeDuplicates(filteredSuggestions);
    final double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () {
          return _onBackPressed(context);
        },
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 60.0,
              centerTitle: true,
              title: H1sss(text: "Present Picker"),
              actions: [
                GestureDetector(
                  onTap: () {
                    //
                    dropdown = !dropdown;
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 3, 12),
                    child: CircleAvatar(
                      // radius: 10,
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                        authProvider!.avatar.toString(),
                      ),
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.black,
              elevation: 0.4,
            ),
            backgroundColor: AppColors.homeBackground,
            body: Stack(
              children: [
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SingleChildScrollView(
                      reverse: false,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.88,
                        child: Column(
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                // H2s(text:sharedData),

                                H2s(text: 'Add To Present Picker'),
                                SizedBox(height: screenHeight * 0.03),
                                Padding(
                                   padding:
                                      const EdgeInsets.fromLTRB(40, 0, 40, 0),
                                  child: Text('Search any website or paste a URL to add to your wish list on Present Picker. Alternatively, select the share button from your web browser and click on Present Picker App to easily add to your wish list.',
                                     textAlign: TextAlign.center,
                                     style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Assistant",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff000000),
                                          
                                  ),),
                                ),
                                SizedBox(height: 15),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(22, 0, 22, 0),
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              
                                              'Need help? ',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Assistant",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'View the step-by-step guide',
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: "Assistant",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              try {
                                                authProvider!.MenuScreen();
                                                // AppService.launchURLService(
                                                //     "https://blog.presentPicker.com/app-start-guide/");
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content:
                                                          Text(e.toString())),
                                                );
                                              }
                                            },
                                        ),
                                        TextSpan(text: '.'),
                                      ])),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 50),
                                  child: SizedBox(
                                    height: 50, // Adjust the height as needed
                                    child: TextField(
                                      // onChanged: updateSuggestions,
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFFFFFFF),
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15.0, vertical: 10),
                                        /* -- Text and Icon -- */
                                        hintText: "Search here...",
                                        hintStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFB3B1B1),
                                        ), // TextStyle
                                        suffixIcon: GestureDetector(
                                            onTap: () {
                                              authProvider!.StoreUrlScreen(
                                                  searchController.text);

                                              if (searchController
                                                  .text.isNotEmpty) {
                                                authProvider!.ScrappingScreen();
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Please Enter URL",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                print("show toast here ");
                                                //   }
                                              }
                                            },
                                            child: Image.asset(
                                              "assets/images/Search.png",
                                              scale: 24,
                                            )), // Icon
                                        /* -- Border Styling -- */
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                            color: Color(0xFFFF0000),
                                          ), // BorderSide
                                        ), // OutlineInputBorder
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                            color: Color(0xFF919191),
                                          ), // BorderSide
                                        ), // OutlineInputBorder
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(45.0),
                                          borderSide: const BorderSide(
                                            width: 1.0,
                                            color: Colors.black,
                                          ), // BorderSide
                                        ), // OutlineInputBorder
                                      ), // InputDecoration
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 17,
                                ),
                                H2ss(text: "Need Inspiration?"),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 0),
                                  child: P1s(
                                      text:
                                          "Browse top retailers other users love "),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: GridView.count(
                                physics:
                                    ScrollPhysics(), // Disable scrolling of GridView
                                shrinkWrap:
                                    true, // Allow the GridView to adjust its height based on the content
                                crossAxisCount:
                                    3, // Number of columns in the grid
                                // mainAxisSpacing: ,
                                crossAxisSpacing: 3,
                                children: List.generate(imageFileNames.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          "Image Tags ${imageFileNames[index]}");
                                      if (imageFileNames[index] ==
                                          "Amazon.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.amazon.com/?&tag=googleglobalp-20&ref=pd_sl_7nnedyywlk_e&adgrpid=82342659060&hvpone=&hvptwo=&hvadid=393493755082&hvpos=&hvnetw=g&hvrand=11350545590403576029&hvqmt=e&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=1011082&hvtargid=kwd-10573980&hydadcr=2246_11061421";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "Nordstrom.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.nordstrom.com/?origin=tab-logo";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "saks_fifth _avenue.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.saksfifthavenue.com/";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "Anthropologie.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.anthropologie.com/";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "target.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.target.com/";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "Amazon") {
                                      } else if (imageFileNames[index] ==
                                          "Lululemon.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://shop.lululemon.com/";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "Neiman_Marcus.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.neimanmarcus.com/en-pk/";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "Sephora.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.sephora.com/";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      } else if (imageFileNames[index] ==
                                          "HomeDepot.png") {
                                        setState(() {
                                          searchController.text =
                                              "https://www.homedepot.com/";
                                          authProvider!.StoreUrlScreen(
                                              searchController.text);

                                          if (searchController
                                              .text.isNotEmpty) {
                                            authProvider!.ScrappingScreen();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter URL",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            print("show toast here ");
                                            //   }
                                          }
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Image.asset(
                                        "assets/images/${imageFileNames[index]}",
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                if (dropdown == true)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          dropdown = false;
                        });
                        // Handle tap to close dropdown here
                        // Set dropdown to false to close it
                        // dropdown = false;
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
                dropdown == true
                    ? Positioned(
                  top: 0, // Set the top position value as per your requirement
                  right: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                    child: Container(
                      height: authProvider!.account.length == 1
                          ? 120
                          : authProvider!.account.length == 2
                              ? 170
                              : authProvider!.account.length == 3
                                  ? 198
                                  : authProvider!.account.length == 4
                                      ? 225
                                      : authProvider!.account.length == 5
                                          ? 253
                                          : 140,
                      width: authProvider!.account.length == 1
                          ? 165
                          : (maxUsernameLength * 8.0) + 70,
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          authProvider!.account.length > 1
                              ? Expanded(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: authProvider!.account.length,
                                      itemBuilder: (context, index) {
                                        var email = authProvider!.account[index]
                                                ["email"]
                                            .toString();
                                        return Column(
                                          children: [
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            GestureDetector(
                                                onTap: () async {
                                                  print("change");
                                                  if (authProvider!
                                                          .account.length >
                                                      1) {
                                                    await authProvider!
                                                        .storeIndex(index);

                                                    Phoenix.rebirth(context);
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    ClipOval(
                                                        child: Image.network(
                                                      authProvider!.account[
                                                              index]["avatar"]
                                                          .toString(),
                                                      height: 17,
                                                      width: 17,
                                                      fit: BoxFit.cover,
                                                    )),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    Text(
                                                      "${authProvider!.account[index]["username"]}",
                                                      // "${authProvider!.account[index]["username"].length > 11 ? authProvider!.account[index]["username"].toString().substring(0, 11) + "..." : authProvider!.account[index]["username"].toString()}",
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        height: 1.6,
                                                        letterSpacing: 1,
                                                        fontFamily:
                                                            "Assistant', sans-serif",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 7,
                                            )
                                          ],
                                        );
                                      }),
                                )
                              : Container(),
                          GestureDetector(
                            onTap: () {
                              authProvider!.onloginScreen();
                              print("object");
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                ),
                                Image.asset(
                                  "assets/images/Add.png",
                                  height: 15,
                                  width: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Add Account",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.6,
                                    letterSpacing: 1,
                                    fontFamily: "Assistant', sans-serif",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // SizedBox(height: 2,),

                          GestureDetector(
                            onTap: () {
                              authProvider!.MenuScreen();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Help",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.6,
                                    letterSpacing: 1,
                                    fontFamily: "Assistant', sans-serif",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 2,),
                          GestureDetector(
                            onTap: () {
                              try {
                                AppService.launchURLService(
                                    "https://blog.presentPicker.com/accountdeletionrequest/");
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())),
                                );
                              }
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Delete Account",
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.6,
                                    letterSpacing: 1,
                                    fontFamily: "Assistant', sans-serif",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              authProvider!.logout();
                              print("logout");
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Log Out",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 1.6,
                                    letterSpacing: 1,
                                    fontFamily: "Assistant', sans-serif",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 13,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
              ],
            )));
  }
}
