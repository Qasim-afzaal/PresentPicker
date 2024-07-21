
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:present_picker/service/app_service.dart';
import 'package:provider/provider.dart';

import '../../provider/authProvider.dart';
import '../../styles/app_color.dart';
import '../../utils/Utils.dart';

class MenuView extends StatefulWidget {
  static const String id = "/home-view";

  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  AuthProvider? authProvider;
  TextEditingController searchController = TextEditingController();
  bool dropdown = false;

  int maxUsernameLength = 0;

// Find the maximum username length in the list

  void initState() {
    // TODO: implement initState
    authProvider = Provider.of<AuthProvider>(context, listen: false);
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        return await authProvider!.HomeScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
          centerTitle: true,
          title: H1sss(text: "Present Picker"),
          leadingWidth: 25,
          leading: Platform.isAndroid
              ? null
              : IconButton(
                  onPressed: () {
                    authProvider!.HomeScreen();
                  },
                  icon: SvgPicture.asset(
                    "assets/images/LeftArrow_white.svg",
                  )),
          actions: [
            GestureDetector(
              onTap: () {
                setState(() {
                  dropdown = !dropdown;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 3, 12),
                child: CircleAvatar(
                  // radius: 10,
                  backgroundColor: Colors.black,

                  backgroundImage:
                      NetworkImage(authProvider!.avatar.toString(), scale: 100),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.black,
          elevation: 0.4,
        ),
        backgroundColor: AppColors.homeBackground,
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              children: [
                Platform.isAndroid
                    ? ListView(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const H2sss(text: 'Add To Present Picker'),
                                SizedBox(height: screenHeight * 0.03),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: P1ss(
                                      text:
                                          'Welcome to the "Add To Present Picker" app! \nWith this app you can add to your wish list on\n'
                                          'Present Picker with one click from your phone or tablet.'),
                                ),
                                Image.asset('assets/images/homeVector.jpg'),
                                const H5s(text: 'How it works:'),
                                SizedBox(height: screenHeight * 0.01),
                                const P1ss(
                                  text:
                                      "1. Using your web browser, find a gift idea you'd like\n to add to your wish list",
                                ),
                                SizedBox(height: screenHeight * 0.03),
                                Image.asset(
                                    'assets/images/web_view_example.png',
                                    height: screenHeight * 0.2),
                                SizedBox(height: screenHeight * 0.03),
                                const P1ss(
                                    text:
                                        "2. Click on the three dots, pictured above, at the top of\n your Chrome browser"),
                                SizedBox(height: screenHeight * 0.05),
                                Image.asset(
                                    'assets/images/web_extension_example.png',
                                    height: screenHeight * 0.2),
                                SizedBox(height: screenHeight * 0.05),
                                const P1ss(
                                    text:
                                        '3. Select "Share..." from the dropdown menu '),
                                SizedBox(height: screenHeight * 0.04),
                                Image.asset(
                                    'assets/images/web_sharing_example.png',
                                    height: screenHeight * 0.2),
                                SizedBox(height: screenHeight * 0.03),
                                const P1ss(
                                    text:
                                        '4. Click on "Present Picker" and fill out the item details'),
                                SizedBox(height: screenHeight * 0.03),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.center,
                                        children: [
                                          const P1ss(
                                            text:
                                                'For further instruction on adding to your wish list, ',
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              try {
                                                AppService.launchURLService(
                                                    "https://blog.presentPicker.com/sign-up-add-to-your-wish-list/");
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(e.toString()),
                                                  ),
                                                );
                                              }
                                            },
                                            child: const P1Underlined(
                                                text:
                                                    'view our step-by-step guide'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 20, 10),
                                  child: SizedBox(
                                    child: B1(
                                      title: 'GO TO Present Picker',
                                      onPressed: () {
                                        try {
                                          AppService.launchURLService(
                                              "https://presentPicker.com/");
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                e.toString(),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Platform.isIOS
                        ? ListView(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const H2sss(text: 'Add To Present Picker'),
                                    SizedBox(height: screenHeight * 0.03),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: P1ss(
                                          text:
                                              'Welcome to the "Add To Present Picker" app! \nWith this app you can add to your wish list on\n'
                                              'Present Picker with one click from your phone or tablet.'),
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    const H5s(text: 'How it works:'),
                                    SizedBox(height: screenHeight * 0.01),
                                    const P1ss(
                                      text:
                                          "1. Using your web browser, find a gift idea you'd like\n to add to your wish list",
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    Image.asset(
                                        'assets/images/IOS_Safari_1.png',
                                        height: screenHeight * 0.3),
                                    const P1ss(
                                        text:
                                            "2. Select the share button, pictured above, at the\nbottom of your screen"),
                                    Image.asset(
                                        'assets/images/ios_sharing_example.png',
                                        height: screenHeight * 0.2),
                                    SizedBox(height: screenHeight * 0.03),
                                    const P1ss(
                                        text:
                                            '3. Click on "Add To Present Picker" and fill out the \nitem details'),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.center,
                                            children: [
                                              const P1ss(
                                                text:
                                                    'For further instruction on adding to your wish list, ',
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  try {
                                                    AppService.launchURLService(
                                                        "https://blog.presentPicker.com/sign-up-add-to-your-wish-list/");
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content:
                                                            Text(e.toString()),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: const P1Underlined(
                                                    text:
                                                        'view our step-by-step guide'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 15, 20, 10),
                                      child: SizedBox(
                                        child: B1(
                                          title: 'GO TO Present Picker',
                                          onPressed: () {
                                            try {
                                              AppService.launchURLService(
                                                  "https://presentPicker.com/");
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container(),
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
                        top:
                            0, // Set the top position value as per your requirement
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
                                      ? 220
                                      : authProvider!.account.length == 5
                                          ? 253
                                          : 140,
                      width: authProvider!.account.length == 1
                          ? 165
                          : (maxUsernameLength * 8.0) + 70,
                            color: Colors.white,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                authProvider!.account.length > 1
                                    ? Expanded(
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                authProvider!.account.length,
                                            itemBuilder: (context, index) {
                                              authProvider!
                                                  .account[index]["email"]
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
                                                                .account
                                                                .length >
                                                            1) {
                                                          // if (authProvider!
                                                          //         .index !=
                                                          //     index) {
                                                          await authProvider!
                                                              .storeIndex(
                                                                  index);
                                                          // authProvider!.switchAccount(email);
                                                          Phoenix.rebirth(
                                                              context);
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          ClipOval(
                                                              child:
                                                                  Image.network(
                                                            authProvider!
                                                                .account[
                                                                    index][
                                                                    "avatar"]
                                                                .toString(),
                                                            height: 17,
                                                            width: 17,
                                                            fit: BoxFit.cover,
                                                          )),
                                                         
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Text(
                                                            "${authProvider!.account[index]["username"]}",
                                                            // "${authProvider!.account[index]["username"].length > 11 ? authProvider!.account[index]["username"].toString().substring(0, 11) + "..." : authProvider!.account[index]["username"].toString()}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              height: 1.6,
                                                              letterSpacing: 1,
                                                              fontFamily:
                                                                  "Assistant', sans-serif",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xff000000),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
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
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Image.asset(
                                        "assets/images/Add.png",
                                        height: 15,
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      const Text(
                                        "Add Account",
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
                                const SizedBox(
                                  height: 5,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    try {
                                      AppService.launchURLService(
                                          "https://blog.presentPicker.com/how-to-get-started-on-the-gift-guide/");
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Help",
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
                                // SizedBox(height: 2,),
                                GestureDetector(
                                  onTap: () {
                                    try {
                                      AppService.launchURLService(
                                          "https://blog.presentPicker.com/accountdeletionrequest/");
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  },
                                  child: const Row(
                                    children: [
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
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Log Out",
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
                                const SizedBox(
                                  height: 13,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
