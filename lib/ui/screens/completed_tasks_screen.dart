import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/data/model/task_model.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/data/urls.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../widgets/task_list_item.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  TaskModel completedTaskModel = TaskModel();
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getAllCompletedTask();
  }

  Future<void> getAllCompletedTask() async {
    final response = await NetworkUtils.getMethod(Urls.getCompletedTaskUrl,
        token: AuthUtils.token);

    if (response != null) {
      _inProgress = true;
      setState(() {});
      completedTaskModel = TaskModel.fromJson(response);
    } else {
      showSnackBarMessage(context,
          'Could not fetch any completed task, please try again', true);
    }
    _inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
        child: _inProgress
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  getAllCompletedTask();
                },
                child: ListView.builder(
                  itemCount: completedTaskModel.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskListItem(
                      subject:
                          completedTaskModel.data?[index].title ?? 'Unknown',
                      description:
                          completedTaskModel.data?[index].description ??
                              'Unknown',
                      date: completedTaskModel.data?[index].createdDate ??
                          'Unknown',
                      type: 'Completed',
                      onEditPress: () {},
                      onDeletePress: () {},
                    );
                  },
                ),
              ));
  }
}
