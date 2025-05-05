// import 'package:flutter/material.dart';

// enum SnackType { error, success, info }

// extension ShowSnackbar on BuildContext {
//   void showSnackBar(SnackType type, String message) {
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: TextStyle(
//             color: type == SnackType.info ? Colors.black : Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: type == SnackType.success
//             ? Colors.green
//             : type == SnackType.error
//                 ? Colors.red
//                 : Colors.white,
//       ),
//     );
//   }
// }
