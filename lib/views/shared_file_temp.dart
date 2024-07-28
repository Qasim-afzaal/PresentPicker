


import 'package:flutter/material.dart';


class SharedFileComingFromOutside extends StatelessWidget {
  String sharedText;

  SharedFileComingFromOutside({Key? key,required this.sharedText}) : super(key: key);

@override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(sharedText ?? "")
          ],
        ),
      ),
    );

  }
}

