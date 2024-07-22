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

  // RegExp emailRegex = new RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  // RegExp userNameRegex = new RegExp(r"^[a-zA-Z0-9_]+$");
  // RegExp allowNumber = new RegExp(r"^[0-9]*$");
  // String email = '';

  // String password = '';

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
          // width: 260,
          //  height: 38,
          child: TextFormField(
          
              controller: myController,
              
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                  // hoverColor: greycolor,
                  hintText: this.widget.text,
                  hintStyle: TextStyle(
                      fontSize: 14.0,
                      // color: tileGreenColor,
                      // fontFamily: secondaryFontFamily
                      ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
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