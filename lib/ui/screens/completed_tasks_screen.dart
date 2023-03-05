import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../widgets/task_list_item.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
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
          type: 'Completed',
          onEditPress: () {},
          onDeletePress: () {},
        );
      },
    ));
  }
}
