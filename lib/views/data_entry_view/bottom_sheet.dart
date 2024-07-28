// import 'package:flutter/material.dart';
// import 'package:the_gift_guide/model/wishlist_model.dart';
//
// import 'custom_button.dart';
//
// class BottomModelSheetView {
//   Future<Widget> savingToWishlist(BuildContext context, WishList data, String token) async {
//     // String response = await ScrapDataViewModel().savingToWishList(context: context, wishList: data, token: token);
//     return Container(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//         child: Wrap(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Center(
//               child: Text(
//                 'Saving.....',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Prata',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 15),
//               child: Center(
//                 child: Text(
//                   'This item is getting added to your wish list\non The Gift Guid',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget addedWishList(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
//         child: Wrap(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Align(
//               alignment: Alignment.centerRight,
//               child: IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(Icons.cancel_outlined),
//               ),
//             ),
//             const Center(
//               child: Text(
//                 'Added To Your Wish List',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Prata',
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(top: 15),
//               child: Center(
//                 child: Text(
//                   'This item has been added to your wish list\non The Gift Guid Select add preferences to\nadd sizes, color, favorite or quantity.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15, left: 70, right: 70),
//               child: CustomButton(
//                 title: 'VIEW WISH LIST',
//                 onPressed: () {},
//                 fontSize: 14,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget errorWhileSaving(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//         child: Wrap(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Center(
//               child: Text(
//                 'Error Saving',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Prata',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 15),
//               child: Center(
//                 child: Text(
//                   'Error occurs while saving your item\non The Gift Guid',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
