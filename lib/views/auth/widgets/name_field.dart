import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


//class customTextField extends
class CustomTextField extends StatefulWidget {
  final String text;
  String Text;
  final TextEditingController controller;
  // final bool checkFocus;
  final EdgeInsets padding;
  CustomTextField(this.text, this.controller, this.padding,this.Text);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final String error = '';
  Size? size;


  get myController => widget.controller;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print("The height: ${size!.height}");

    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: widget.padding,

          child: TextFormField(
          
              controller: myController,
              
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                  // hoverColor: greycolor,
                  hintText: this.widget.text,
                  hintStyle: const TextStyle(
                      fontSize: 14.0,
                      // color: tileGreenColor,
                      // fontFamily: secondaryFontFamily
                      ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(color: Colors.black))),
              validator: (value) {
                if (value!.isEmpty) {
                  print("The value:${value}");
                  return widget.Text;
                }
               
               
                else
                  return null;
              }),
        ),
      ],
    );
    
  }
}