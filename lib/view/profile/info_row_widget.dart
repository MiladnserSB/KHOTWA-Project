// import 'package:flutter/material.dart';
// import 'package:khotwa/shared/constants/colors.dart';

// class InfoRowWidget extends StatelessWidget {
// final IconData icon;
//   final String label;
//   final String value;

//   const InfoRowWidget({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Icon(icon, color: isDark ? Colors.white70 : primaryColor),
//           const SizedBox(width: 12),
//           Text(
//             '$label:',
//             style: TextStyle(
              
//               fontWeight: FontWeight.bold,
//               color: isDark ? const Color.fromRGBO(255, 255, 255, 1) : textBlack,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: isDark ? Colors.white70 : textBlack,
//                   fontWeight: FontWeight.w600,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }