import 'package:flutter/material.dart';

class CustomizedChipWidget extends StatelessWidget {
  const CustomizedChipWidget({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  Color getBackgroundColor() {
    switch (type) {
      case 'New':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.red;
      case 'Progress':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getBackgroundColor();

    return Chip(
      backgroundColor: backgroundColor,
      label: Text(type),
    );
  }
}

// Below code is my proof of failure.
// class CustomizedChipWidget extends StatelessWidget {
//   // var backgroundColor;
//
//   const CustomizedChipWidget({
//     super.key,
//     required this.type,
//     required this.backgroundColor,
//   });
//
//   final String type;
//   final Color backgroundColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Chip(label: Text(type), backgroundColor: backgroundColor);}
//       // ),
//
//       // showColoredChip(Widget chip) {
//       //   if (type == 'New') {
//       //         return Colors.blue;
//       //     } else if (type == 'Completed') {
//       //         return Colors.green;
//       //     } else if (type == 'Cancelled') {
//       //     return Colors.grey;
//       //     } else {
//       //     return Colors.red;
//       //     }
//       // }
//
//       //   backgroundColor: if (type == 'New') {
//       //     return Colors.blue;
//       // } else if (type == 'Completed') {
//       //     return Colors.green;
//       // } else if (type == 'Cancelled') {
//       // return Colors.grey;
//       // } else {
//       // return Colors.red;
//       // }
//       // return Color
//   //   );
//   // }
//
// // showColoredChip( type) {
// // final Color backgroundColor;
// // if (type == 'New') {
// // backgroundColor = Colors.blue;
// // } else if (type == 'Completed') {
// // backgroundColor = Colors.green;
// // } else if (type == 'Cancelled') {
// // backgroundColor = Colors.grey;
// // } else {
// // backgroundColor = Colors.red;
// // }
// // return backgroundColor;
// // }
// // }
//
// }