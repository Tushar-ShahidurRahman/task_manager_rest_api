import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/data/model/task_model.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../../data/urls.dart';
import '../widgets/dashboard_item.dart';
import '../widgets/status_change_bottom_sheet.dart';
import '../widgets/task_list_item.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  // I have created this class instance for saving new task inside it.
  //I found that inside this TaskModel class a list called data was created automatically, when i
  // created this class using "json to dart". I copied "response" from the postman reply.
  TaskModel newTaskModel = TaskModel();

  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getAllNewTask();
  }

  Future<void> getAllNewTask() async {
    _inProgress = true;
    setState(() {});
    final response = await NetworkUtils.getMethod(Urls.getNewTaskUrl,
        token: AuthUtils.token);

    if (response != null) {
      //  i have to save the result some where. Maybe inside a class or a list.
      newTaskModel = TaskModel.fromJson(response);
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, 'Could not fetch new task. please try again', true);
      }
    }
    _inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackground(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardItem(
                  numberOfTasks: newTaskModel.data?.length ?? 0,
                  typeOfTasks: 'New task',
                ),
              ),
              const Expanded(
                child: DashboardItem(
                  // numberOfTasks: completedTaskModel.data?.length ?? 0,
                  numberOfTasks: 13,

                  typeOfTasks: 'Completed task',
                ),
              ),
              const Expanded(
                child: DashboardItem(
                  numberOfTasks: 12,
                  typeOfTasks: 'Cancelled task',
                ),
              ),
              const Expanded(
                child: DashboardItem(
                  numberOfTasks: 12,
                  typeOfTasks: 'In progress task',
                ),
              ),
            ],
          ),
          Expanded(
            child: _inProgress
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      getAllNewTask();
                    },
                    child: ListView.builder(
                      reverse: true,
                      itemCount: newTaskModel.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskListItem(
                          subject: newTaskModel.data?[index].title ?? 'Unknown',
                          description: newTaskModel.data?[index].description ??
                              'Unknown',
                          date: newTaskModel.data?[index].createdDate ??
                              'Unknown',
                          type: 'New',
                          onEditPress: () {
                            showChangedTaskStatus(currentValue: 'New',
                              newTaskModel.data?[index].sId ?? '',
                              onTaskChangeCompleted: () {
                                getAllNewTask();
                              },
                            );
                          },
                          onDeletePress: () {},
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

//  showTaskChangeId method was here... Now i changed its location to lib/ui/widgets.
// because i want to call it from other pages too... So, i made it's existence global.
}
