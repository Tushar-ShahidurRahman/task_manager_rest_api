import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/screens/update_profile_screen.dart';

class UserProfileTileWidget extends StatelessWidget {
  const UserProfileTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => const UpdateProfileScreen(),));
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        tileColor: Colors.green,
        leading: CircleAvatar(
          radius: 18,
          child: Image.network(
              'https://avatars.githubusercontent.com/u/46148235?s=96&v=4'),),
        title: const Text('Tushar Shahidur Rahman', style: TextStyle(color: Colors.white),),
        subtitle: const Text('ptushar004@gmail.com', style: TextStyle(color: Colors.white54),),
      ),
    );
  }
}