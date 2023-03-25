import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/data/urls.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';

import '../../main.dart';

deleteTask({required String taskId, required VoidCallback onTaskDeleted}) {
  showDialog(
    context: TaskManagerApp.navigatorGlobalKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete task'),

        actions: [
          // ListTile(title: Text("Yes"),)
          OutlinedButton(
              onPressed: () async {
                _deleteTaskApiCall(taskId, () {
                  onTaskDeleted();
                });

              },
              child: const Text('Yes')),
          OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'))
        ],
      );
    },
  );
}
// Extracted this method for Decluttering reason.
Future<void> _deleteTaskApiCall(
    String taskId, VoidCallback onTaskDeleted) async {
  final response =
      await NetworkUtils.getMethod(Urls.getDeleteTaskUrl(id: taskId));
  if (response != null) {
    showSnackBarMessage(
        TaskManagerApp.navigatorGlobalKey.currentContext!, 'Task deleted.');
    onTaskDeleted();
  } else {
    showSnackBarMessage(TaskManagerApp.navigatorGlobalKey.currentContext!,
        'Task deletion failed, Please try again', true);
  }
}
