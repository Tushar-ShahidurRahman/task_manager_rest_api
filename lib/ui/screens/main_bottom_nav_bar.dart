import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_rest_api/ui/screens/cancelled_tasks_screen.dart';
import 'package:task_manager_rest_api/ui/screens/completed_tasks_screen.dart';
import 'package:task_manager_rest_api/ui/screens/inprogress_tasks_screen.dart';
import 'package:task_manager_rest_api/ui/screens/new_tasks_screen.dart';

import '../widgets/user_profile_tile_widget.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedScreen = 0;
  final List<Widget> _screens = const [
    NewTasksScreen(),
    CompletedTasksScreen(),
    CancelledTasksScreen(),
    InProgressTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const UserProfileTileWidget(),
              Expanded(child: _screens[_selectedScreen])
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen(),
                ));
          },
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.add,
          )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black38,
        currentIndex: _selectedScreen,
        elevation: 4,
        onTap: (index) {
          _selectedScreen = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.new_label_outlined), label: 'New'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.close_outlined), label: 'Canceled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle), label: 'In Progress'),
        ],
      ),
    );
  }
}
