import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  /// LIVE API BASE
  static const String _baseURL = "https://api.presentPicker.com/";

  /// TEST API BASE
  // static const String _baseURL = "https://test-api.presentPicker.com/";

  /// END POINTS
  static const String _login = "api/user/login";
  static const String _checkEmailExists = "api/user/check-email";
  static const String _scrapingEndPoint = "api/scraping/webScraping?url=";
  static const String _wishlistEndPoint = "api/wish";

  /// COMPLETE URLS
  static const String scrappingURL = "http://54.214.63.94:4000/api/scrape";
  static const String addWishListURL = "https://test.presentPicker.com/api/wish/create";
  static const String loginURL = _baseURL + _login;
  static const String checkEmailExistsURL = _baseURL + _checkEmailExists;
  static const String scrapingURL = _baseURL + _scrapingEndPoint;
  static const String wishlistURL = _baseURL + _wishlistEndPoint;

  ///button B3 TextStyle
  static const TextStyle b3TextStyleWithUnderLine = TextStyle(
    color: Colors.black,
    fontSize: 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w300,
    decoration: TextDecoration.underline,
    fontFamily: 'Assistant',
  );

  ///p1 text style
  static const TextStyle p1TextStyle = TextStyle(
    fontSize: 14,
    height: 1.6,
    fontFamily: "Assistant",
    fontWeight: FontWeight.w500,
    color: Color(0xff000000),
  );

  ///p1 with underline
  static const TextStyle p1WithUnderline = TextStyle(
    fontSize: 14,
    height: 1.6,
    fontFamily: "Assistant",
    fontWeight: FontWeight.w500,
    color: Color(0xff000000),
    decoration: TextDecoration.underline,
  );
  static const TextStyle b3TextStyleWithOutUnderLine = TextStyle(
    color: Colors.black,
    fontSize: 12,
    letterSpacing: 0,
    fontWeight: FontWeight.w300,
    fontFamily: 'Assistant',
  );

  static void showFlushBarMessages(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          forwardAnimationCurve: Curves.decelerate,
          duration: const Duration(seconds: 4),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          padding: const EdgeInsets.all(15),
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xffC0945A),
          borderRadius: BorderRadius.circular(15),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context));
  }

  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

class H1 extends Text {
  H1({
    super.key,
    required String text,
  }) : super(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 38,
            fontFamily: "FuturaLT",
            fontWeight: FontWeight.w400,
            letterSpacing: 4,
            color: Color(0xff000000),
          ),
        );
}
class H1s extends Text {
  H1s({
    super.key,
    required String text,
  }) : super(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "FuturaLT",
            fontWeight: FontWeight.w400,
            letterSpacing: 4,
            color: Color(0xff000000),
    
          ),

        );
}
class H1sss extends Text {
  H1sss({
    super.key,
    required String text,
  }) : super(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontFamily: "FuturaLT",
            fontWeight: FontWeight.w400,
            letterSpacing: 4,
            color: Colors.white,
    
          ),

        );
}


class H1ss extends Text {
  H1ss({
    super.key,
    required String text,
  }) : super(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: "FuturaLT",
            fontWeight: FontWeight.w400,
            letterSpacing: 4,
            color: Colors.white,
    
          ),

        );
}

class H2 extends Text {
  const H2({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: "Prata",
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class H2ss extends Text {
  const H2ss({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "Prata",
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class H2s extends Text {
  const H2s({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            fontFamily: "Prata",
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class H2sss extends Text {
  const H2sss({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 29,
            fontFamily: "Prata",
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}
class H2sssss extends Text {
  const H2sssss({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 27,
            fontFamily: "Prata",
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}
class headingText extends StatefulWidget {
  
   String text;
   double size;
  

   headingText({super.key, required this.size,required this.text,});

  @override
  State<headingText> createState() => _headingTextState();
}

class _headingTextState extends State<headingText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.text,style: TextStyle(fontSize: widget.size,fontFamily: "Prata",
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000) ),),
    );
  }
}
class H2ssss extends Text {
  const H2ssss({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
            fontFamily: "Prata",
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class H5 extends Text {
  const H5({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Prata",
            color: Color(0xff000000),
            fontWeight: FontWeight.w600,
          ),
        );
}

class H5s extends Text {
  const H5s({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 23,
            fontFamily: "Prata",
            color: Color(0xff000000),
            fontWeight: FontWeight.w500,
          ),
        );
}

class H9 extends Text {
  const H9({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 12,
            height: 1.6,
            letterSpacing: 0,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w600,
            color: Color(0xff000000),
          ),
        );
}

class P1 extends Text {
  const P1({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class P1ss extends Text {
  const P1ss({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 0,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        );
}
class P1s extends Text {
  const P1s({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            height: 1.6,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}
class P1sss extends Text {
  const P1sss({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 1.6,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class P1Underlined extends Text {
  const P1Underlined({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 0,
            fontFamily: "Assistant",
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        );
}

class P1Underlineds extends Text {
  const P1Underlineds({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            height: 0,
            fontFamily: "Assistant",
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class P2 extends Text {
  const P2({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            height: 1.6,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}
class P2s extends Text {
  const P2s({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17,
            height: 1.8,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w400,
            color: Color(0xff000000),
          ),
        );
}

class P2WithOutCentered extends Container {
  P2WithOutCentered({
    super.key,
    required String text,
  }) : super(
          margin: const EdgeInsets.only(top: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 12,
                height: 1.6,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
              ),
            ),
          ),
        );
}

class P3 extends Text {
  const P3({
    super.key,
    required String text,
  }) : super(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            height: 1.6,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        );
}

class BL extends StatelessWidget {
  // final String title;
  // final Function()? onPressed;
  // const BL({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double widthVariable = MediaQuery.of(context).size.width;
    return SizedBox(
        width: widthVariable,
        height: 40,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shadowColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: (){},
          child:CircularProgressIndicator(color: Colors.white,)
        ));
  }
}
class B1 extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  const B1({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double widthVariable = MediaQuery.of(context).size.width;
    return SizedBox(
        width: widthVariable,
        height: 44,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shadowColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: onPressed,
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 15,
              fontFamily: "Assistant",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ));
  }
}

class B3 extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const B3({Key? key, required this.title, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: "Assistant",
          color: Color(0xff000000),
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class TextFieldLabel extends Container {
  TextFieldLabel({
    super.key,
    required String text,
  }) : super(
          margin: const EdgeInsets.only(top: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "Assistant",
                fontWeight: FontWeight.w500,
                color: Color(0xff000000),
                height: 1.4,
              ),
            ),
          ),
        );
}

class UiField extends InputDecoration {
  const UiField({
    border,
    bool isFromPassword = false,
    Widget? suffixIcon,
  }) : super(
          // isDense: true,
          errorStyle: const TextStyle(
            fontSize: 12,
            fontFamily: "Assistant",
            fontWeight: FontWeight.w500,
            // height: 1.4,
            // decorationStyle: TextDecorationStyle.solid,
          ),
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xff919191), width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xff919191), width: 1),
          ),
          hoverColor: Colors.black,
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xffc7c7c7), width: 1),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xffFF0000), width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xff000000), width: 1),
          ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(maxHeight: 40, minWidth: 40),
          // TextField height controlled by 'vertical'
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        );
}

class PasswordFieldUI extends InputDecoration {
  const PasswordFieldUI({
    border,
    Widget? suffixIcon,
  }) : super(
          isDense: true,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xff919191), width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xff919191), width: 1),
          ),
          hoverColor: Colors.black,
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xffc7c7c7), width: 1),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xffFF0000), width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(0xff000000), width: 1),
          ),
          suffixIcon: suffixIcon,
        );
}
