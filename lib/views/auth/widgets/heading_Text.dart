import 'package:flutter/material.dart';


class headingText extends StatefulWidget {
  
   String text;
   double size;
   String fontFamily;
   Color color;
   FontWeight fontWeight;

   headingText({super.key, required this.size,required this.text,required this.fontFamily,required this.color ,required this.fontWeight});

  @override
  State<headingText> createState() => _headingTextState();
}

class _headingTextState extends State<headingText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.text,style: TextStyle(fontSize: widget.size,fontFamily: widget.fontFamily,fontStyle: FontStyle.normal,fontWeight: widget.fontWeight,color: widget.color ),),
    );
  }
}