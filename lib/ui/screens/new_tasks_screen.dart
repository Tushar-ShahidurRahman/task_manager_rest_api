import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/data/model/task_model.dart';
import 'package:task_manager_rest_api/data/model/task_status_count_model.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/delete_task_alartbox.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';
import 'package:task_manager_rest_api/ui/screens/completed_tasks_screen.dart';

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
  TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel();

  // TaskModel completedTaskModel = TaskModel();
  // int? sum;
  // int? completedSum;
  // int? cancelledSum;
  // int? progressSum;
  int? newTaskCount;
  int? completedTaskCount;
  int? cancelledTaskCount;
  int? progressTaskCount;
  bool _inProgress = false;

  // int? taskSum;

  @override
  void initState() {
    super.initState();
    getAllNewTask();
    getTaskCount();
  }


  Future<void> getTaskCount() async {
    final response = await NetworkUtils.getMethod(Urls.getTaskStatusCountUrl);

    if (response != null && response['status'] == 'success') {
      // make a model class for task status count data and insert response in it.
      taskStatusCountModel = TaskStatusCountModel.fromJson(response);
      // log(taskStatusCountModel.data.toString());

      taskStatusCountModel.data?.forEach((element) {
        if(element.sId == 'New') {
          newTaskCount = element.sum;
        } else if(element.sId == 'Completed') {
          completedTaskCount = element.sum;
        } else if(element.sId == 'Cancelled') {
          cancelledTaskCount = element.sum;
        } else if(element.sId == 'Progress') {
          progressTaskCount = element.sum;
        }
      });

    } else {
      if (mounted) {
        showSnackBarMessage(context, 'could not update task count', true);
      }
    }
  }

      // Tried and failed
  // Future<int?> getTaskCount() async {
  //   final response = await NetworkUtils.getMethod(Urls.getTaskStatusCountUrl);
  //
  //   if (response != null && response['status'] == 'success') {
  //     // make a model class for task status count data.
  //     taskStatusCountModel = TaskStatusCountModel.fromJson(response);
  //     log(taskStatusCountModel.data.toString());
  //     // newTaskCount =  taskStatusCountModel.data?[0].sum ?? 0;
  //     // completedTaskCount = taskStatusCountModel.data?[1].sum ?? 0;
  //     // completedTaskCount =  taskStatusCountModel.data?[1].sId as int?;
  //     // final data = response['data'];
  //     //
  //     // Map<String, int> sumMap = {};
  //     //
  //     // for (var item in data) {
  //     //   String id = item['_id'];
  //     //   int sum = item['sum'];
  //     //   sumMap[id] = sum;
  //     // }
  //     //
  //     // // return sumMap;
  //     //
  //     // // sum  =
  //     //
  //     // if (sumMap["_id"] == "Completed") {
  //     //   setState(() {
  //     //     completedSum = sumMap["sum"];
  //     //   });
  //     // } else if (sumMap['_id'] == 'Cancelled') {
  //     //   cancelledSum = sumMap['sum'];
  //     //   setState(() {});
  //     // } else if (sumMap['_id'] == 'Progress') {
  //     //   progressSum = sumMap['sum'];
  //     //   setState(() {});
  //     // }
  //     // return null;
  //
  //     // return sum;}
  //     //
  //     //   sum = getSum();
  //     //   // if (response['data']['id'] == 'Cancelled') {
  //     //   //   return sum = response['data']['sum'];
  //     //   // }
  //     // }
  //     // return 0;
  //   } else {
  //     if (mounted) {
  //       showSnackBarMessage(context, 'could not update task count', true);
  //     }
  //   }
  // }

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
              Expanded(
                child: DashboardItem(
                  // numberOfTasks: completedTaskModel.data?.length ?? 0,
                  // numberOfTasks: 65,
                  numberOfTasks: completedTaskCount ?? 0,

                  typeOfTasks: 'Completed task',
                ),
              ),
              Expanded(
                child: DashboardItem(
                  // numberOfTasks: 12,
                  numberOfTasks: cancelledTaskCount ?? 0,
                  typeOfTasks: 'Cancelled task',
                ),
              ),
              Expanded(
                child: DashboardItem(
                  numberOfTasks: progressTaskCount ?? 0,
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
                            showChangedTaskStatus(
                              currentValue: 'New',
                              newTaskModel.data?[index].sId ?? '',
                              onTaskChangeCompleted: () {
                                getAllNewTask();
                              },
                            );
                          },
                          onDeletePress: () {
                            deleteTask(
                              taskId:
                                  newTaskModel.data?[index].sId ?? 'Unknown',
                              onTaskDeleted: () => getAllNewTask(),
                            );
                          },
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
