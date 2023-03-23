import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/model/task_model.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/data/urls.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/widgets/status_change_bottom_sheet.dart';

import '../widgets/screen_background_widget.dart';
import '../widgets/task_list_item.dart';

class InProgressTasksScreen extends StatefulWidget {
  const InProgressTasksScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTasksScreen> createState() => _InProgressTasksScreenState();
}

class _InProgressTasksScreenState extends State<InProgressTasksScreen> {
  TaskModel progressTaskModel = TaskModel();
  bool _inProgress = false;

  Future<void> getAllProgressTask() async {
    _inProgress = true;
    setState(() {});
    final response = await NetworkUtils.getMethod(Urls.getProgressTaskUrl);
    if (response != null) {
      progressTaskModel = TaskModel.fromJson(response);
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            'Could not fetch any in progress task, please try again', true);
      }
    }
    _inProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllProgressTask();
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
            getAllProgressTask();
          },
          child: ListView.builder(
            itemCount: progressTaskModel.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return TaskListItem(
                subject:
                progressTaskModel.data?[index].title ?? 'Unknown',
                description: progressTaskModel.data?[index].description ??
                    'Unknown',
                date: progressTaskModel.data?[index].createdDate ??
                    'Unknown',
                type: 'Progress',
                onEditPress: () {
                  showChangedTaskStatus(
                    progressTaskModel.data?[index].sId ?? 'Unknown',
                    currentValue: 'Progress',
                    onTaskChangeCompleted: () {
                      getAllProgressTask();
                    },);
                },
                onDeletePress: () {},
              );
            },
          ),
        ));
    ;
  }
}
