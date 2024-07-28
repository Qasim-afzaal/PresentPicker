// class WishListConfirmation extends StatelessWidget {
//   const WishListConfirmation({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final double widthVariable = MediaQuery.of(context).size.width;
//     final double heightVariable = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               color: Colors.white,
//               width: widthVariable,
//               height: heightVariable * 0.35,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     alignment: Alignment.topRight,
//                     width: widthVariable * 0.9,
//                     child: const Icon(Icons.close),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       'Add To Present Picker Wish List',
//                       style: TextStyle(
//                         fontFamily: 'Assistant',
//                         fontSize: 27,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: heightVariable * 0.1,
//                     width: widthVariable * 0.75,
//                     child: const Text(
//                       'This item has been added to your wish list on Present Picker. View the item on your wish list to add sizes, color, quantity', or select as a favorite item.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'Assistant',
//                         fontSize: 18,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: widthVariable * 0.5,
//                     height: heightVariable * 0.06,
//                     child: CustomMaterialButton(
//                       onTap: () {},
//                       text: 'VIEW WISH LIST',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
