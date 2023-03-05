import 'package:flutter/material.dart';

import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item.dart';

class InProgressTasksScreen extends StatefulWidget {
  const InProgressTasksScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTasksScreen> createState() => _InProgressTasksScreenState();
}

class _InProgressTasksScreenState extends State<InProgressTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            return TaskListItem(
              subject: 'Title',
              description: 'Description here',
              date: '12/12/22',
              type: 'In progress',
              onEditPress: () {},
              onDeletePress: () {},
            );
          },
        ));;
  }
}
