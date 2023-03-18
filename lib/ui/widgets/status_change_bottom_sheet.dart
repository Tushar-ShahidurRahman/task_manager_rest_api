import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/main.dart';

import '../../data/auth_utils.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utils/snackbar_message.dart';
import 'app_elevated_button.dart';

showChangedTaskStatus(String taskId, {required String currentValue,  required VoidCallback onTaskChangeCompleted}) {
  String status = currentValue;
  bool _inProgress = false;

  showModalBottomSheet(
    context: TaskManagerApp.navigatorGlobalKey.currentContext!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, changeState) {
          return Column(
            children: [
              RadioListTile(
                  value: 'New',
                  title: const Text('New'),
                  groupValue: status,
                  onChanged: (state) {
                    status = state!;
                    changeState(() {});
                  }),
              RadioListTile(
                  value: 'Completed',
                  title: const Text('Completed'),
                  groupValue: status,
                  onChanged: (state) {
                    status = state!;
                    changeState(() {});
                  }),
              RadioListTile(
                  value: 'Cancelled',
                  title: const Text('Cancelled'),
                  groupValue: status,
                  onChanged: (state) {
                    status = state!;
                    changeState(() {});
                  }),
              RadioListTile(
                  value: 'Progress',
                  title: const Text('Progress'),
                  groupValue: status,
                  onChanged: (state) {
                    status = state!;
                    changeState(() {});
                  }),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
                child: AppElevatedButton(
                    child: const Text('Change Task Type'),
                    onTap: () async {
                      // should i use inProgress flag here?
                      _inProgress = true;
                      changeState(() {});
                      final response = await NetworkUtils.getMethod(
                          token: AuthUtils.token,
                          Urls.updateTaskStatusUrl(
                              taskId: taskId, status: status));
                      if (response != null) {
                        // getAllNewTask();
                        //How can i solve this method called from other pages?
                        // should i use voidCallback? I think yes. And then pass it here.
                        onTaskChangeCompleted();
                        Navigator.pop(context);
                      } else {
                        // if (mounted) {
                          showSnackBarMessage(
                              // context,
                            TaskManagerApp.navigatorGlobalKey.currentContext!,
                              'Could not change task status, please try again',
                              true);
                        // }
                      }
                      _inProgress = false;
                      changeState(() {});
                    }),
              ),
            ],
          );
        },
      );
    },
  );
}