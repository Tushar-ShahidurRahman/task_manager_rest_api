import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../widgets/dashboard_item.dart';
import '../widgets/task_list_item.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: DashboardItem(
                  numberOfTasks: 12,
                  typeOfTasks: 'New task',
                ),
              ),
              Expanded(
                child: DashboardItem(
                  numberOfTasks: 09,
                  typeOfTasks: 'Completed task',
                ),
              ),
              Expanded(
                child: DashboardItem(
                  numberOfTasks: 12,
                  typeOfTasks: 'Cancelled task',
                ),
              ),
              Expanded(
                child: DashboardItem(
                  numberOfTasks: 12,
                  typeOfTasks: 'In progress task',
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return TaskListItem(
                subject: 'Title',
                description: 'Description here',
                date: '12/12/22',
                type: 'New',
                onEditPress: () {},
                onDeletePress: () {},
              );
            },
          )),
        ],
      ),
    );
  }
}


