import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.numberOfTasks,
    required this.typeOfTasks,
  });

  final int numberOfTasks;
  final String typeOfTasks;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              numberOfTasks.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 6),
            FittedBox(child: Text(typeOfTasks)),
          ],
        ),
      ),
    );
  }
}
