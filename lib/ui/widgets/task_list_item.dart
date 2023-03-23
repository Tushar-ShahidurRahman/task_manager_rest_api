import 'package:flutter/material.dart';

import 'customized_chip_widget.dart';

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
                CustomizedChipWidget(
                  type: type,
                  // backgroundColor: backgroundColor,
                ),
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


