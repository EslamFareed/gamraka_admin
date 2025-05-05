// import 'package:flutter/material.dart';

// extension NavigationHelper on BuildContext {
//   void goTo(Widget screen) {
//     Navigator.push(
//         this,
//         MaterialPageRoute(
//           builder: (context) => screen,
//         ));
//   }

//   void goOff(Widget screen) {
//     Navigator.pushReplacement(
//         this,
//         MaterialPageRoute(
//           builder: (context) => screen,
//         ));
//   }

//   void goOffAll(Widget screen) {
//     Navigator.pushAndRemoveUntil(
//       this,
//       MaterialPageRoute(
//         builder: (context) => screen,
//       ),
//       (route) => false,
//     );
//   }

//   void off() {
//     if (Navigator.canPop(this)) Navigator.pop(this);
//   }
// }
