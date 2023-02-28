import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Column(
        children: [],
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
              icon: Icon(Icons.done_outline),
              label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.close_outlined), label: 'Canceled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle), label: 'Progress'),
        ],
      ),
    );
  }
}
