import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/model/task_model.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/data/urls.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/widgets/delete_task_alartbox.dart';
import 'package:task_manager_rest_api/ui/widgets/status_change_bottom_sheet.dart';

import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item.dart';

class CancelledTasksScreen extends StatefulWidget {
  const CancelledTasksScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTasksScreen> createState() => _CancelledTasksScreenState();
}

class _CancelledTasksScreenState extends State<CancelledTasksScreen> {
  TaskModel cancelledTasks = TaskModel();
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    //  call the method here to fetch updated _cancelledTask list.
    getAllCancelledTasks();
  }

  Future<void> getAllCancelledTasks() async {
    _inProgress = true;
    setState(() {});
    final response = await NetworkUtils.getMethod(Urls.getCancelledTaskUrl);
    if (response != null) {
      cancelledTasks = TaskModel.fromJson(response);
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, 'Could not fetch cancelled tasks, please try again', true);
      }
    }
    _inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: _inProgress
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.green,
              ))
            : RefreshIndicator(
                onRefresh: () async {
                  getAllCancelledTasks();
                },
                child: ListView.builder(
                  itemCount: cancelledTasks.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskListItem(
                      subject: cancelledTasks.data?[index].title ?? 'Unknown',
                      description:
                          cancelledTasks.data?[index].description ?? 'Unknown',
                      date:
                          cancelledTasks.data?[index].createdDate ?? 'Unknown',
                      type: 'Cancelled',
                      onEditPress: () {
                        showChangedTaskStatus(
                          cancelledTasks.data?[index].sId ?? 'Unknown',
                          currentValue: 'Cancelled',
                          onTaskChangeCompleted: () {
                            getAllCancelledTasks();
                          },
                        );
                      },
                      onDeletePress: () {
                        deleteTask(
                          taskId: cancelledTasks.data?[index].sId ?? 'Unknown',
                          onTaskDeleted: () => getAllCancelledTasks(),
                        );
                      },
                    );
                  },
                ),
              ));
    ;
  }
}
