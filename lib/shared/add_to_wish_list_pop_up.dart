// import 'package:flutter/material.dart';
// import 'package:the_gift_guide/shared/material_button.dart';
//
// class AddToWishListPopUp extends StatefulWidget {
//   const AddToWishListPopUp({Key? key}) : super(key: key);
//
//   @override
//   State<AddToWishListPopUp> createState() => _AddToWishListPopUpState();
// }
//
// class _AddToWishListPopUpState extends State<AddToWishListPopUp> {
//   bool value = false;
//   @override
//   Widget build(BuildContext context) {
//     final double widthVariable = MediaQuery.of(context).size.width;
//     final double heightVariable = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SizedBox(
//         width: widthVariable * 0.9,
//         height: heightVariable * 0.8,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(alignment: Alignment.topRight, width: widthVariable, child: const Icon(Icons.close)),
//             const Text(
//               'Add To Present Picker\n Wish List',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontFamily: 'Assistant', fontSize: 27),
//             ),
//             // SizedBox(height: heightVariable * 0.2),
//             const Padding(
//               padding: EdgeInsets.only(bottom: 20),
//               child: Text('Show More Images',
//                   style: TextStyle(
//                       fontFamily: 'Assistant',
//                       fontSize: 12,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w400,
//                       letterSpacing: 0.05,
//                       decoration: TextDecoration.underline)),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               child: SizedBox(
//                 width: widthVariable * 0.9,
//                 height: heightVariable * 0.06,
//                 child: const TextField(
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10),
//                       border: OutlineInputBorder(borderSide: BorderSide()),
//                       label: Text('Name of Item'),
//                       labelStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Assistant', fontSize: 12)),
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: widthVariable * 0.25,
//                     height: heightVariable * 0.06,
//                     child: const TextField(
//                       decoration: InputDecoration(
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(borderSide: BorderSide()),
//                           label: Text('Price'),
//                           labelStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Assistant', fontSize: 12)),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: widthVariable * 0.25,
//                     height: heightVariable * 0.06,
//                     child: const TextField(
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(10),
//                         border: OutlineInputBorder(borderSide: BorderSide()),
//                         label: Text('Size'),
//                         labelStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Assistant', fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: widthVariable * 0.25,
//                     height: heightVariable * 0.06,
//                     child: const TextField(
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(10),
//                         border: OutlineInputBorder(borderSide: BorderSide()),
//                         label: Text('Quantity'),
//                         labelStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Assistant', fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: SizedBox(
//                       width: widthVariable * 0.55,
//                       height: heightVariable * 0.06,
//                       child: const TextField(
//                         decoration: InputDecoration(
//                             contentPadding: EdgeInsets.all(10),
//                             border: OutlineInputBorder(borderSide: BorderSide()),
//                             label: Text('Color/Type'),
//                             labelStyle: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Assistant', fontSize: 12)),
//                       ),
//                     ),
//                   ),
//                   Checkbox(
//                     value: value,
//                     onChanged: (value) {
//                       setState(() {
//                         this.value = value!;
//                       });
//                     },
//                   ),
//                   const Text('Favourite')
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: widthVariable * 0.85,
//               height: heightVariable * 0.06,
//               child: CustomMaterialButton(onTap: () {}, text: 'ADD TO WISH LIST'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
