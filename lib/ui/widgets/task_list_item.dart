import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.subject,
    required this.description,
    required this.date,
    required this.type,
    required this.onEditPress,
    required this.onDeletePress,
  });

  final String subject, description, date, type;
  final VoidCallback onEditPress, onDeletePress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 6),
            Text(date),
            const SizedBox(height: 6),
            Row(
              children: [
                // CustomizedChipWidget(type: type, backgroundColor: type == 'New' ? Colors.blue : Colors.greenAccent,),
                // CustomizedChipWidget(
                //   type: type,
                //   // backgroundColor: backgroundColor,
                // ),
                const Spacer(),
                IconButton(
                    onPressed: onEditPress, icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: onDeletePress, icon: const Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
//    This two braces are necessary and im experimenting here.
  }
}

    class CustomizedChipWidget extends StatelessWidget {
      // var backgroundColor;

      const CustomizedChipWidget({
        super.key,
        required this.type,
        required this.backgroundColor,
      });

      final String type;
      final Color backgroundColor;

      @override
      Widget build(BuildContext context) {
        return Chip(label: Text(type), backgroundColor: backgroundColor);}
          // ),

          // showColoredChip(Widget chip) {
          //   if (type == 'New') {
          //         return Colors.blue;
          //     } else if (type == 'Completed') {
          //         return Colors.green;
          //     } else if (type == 'Cancelled') {
          //     return Colors.grey;
          //     } else {
          //     return Colors.red;
          //     }
          // }

          //   backgroundColor: if (type == 'New') {
          //     return Colors.blue;
          // } else if (type == 'Completed') {
          //     return Colors.green;
          // } else if (type == 'Cancelled') {
          // return Colors.grey;
          // } else {
          // return Colors.red;
          // }
          // return Color
      //   );
      // }

    // showColoredChip( type) {
    // final Color backgroundColor;
    // if (type == 'New') {
    // backgroundColor = Colors.blue;
    // } else if (type == 'Completed') {
    // backgroundColor = Colors.green;
    // } else if (type == 'Cancelled') {
    // backgroundColor = Colors.grey;
    // } else {
    // backgroundColor = Colors.red;
    // }
    // return backgroundColor;
    // }
    // }

    }