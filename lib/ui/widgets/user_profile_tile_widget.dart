import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/ui/screens/login_screen.dart';
import 'package:task_manager_rest_api/ui/screens/update_profile_screen.dart';

class UserProfileTileWidget extends StatelessWidget {
  const UserProfileTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ));
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        tileColor: Colors.green,
        leading: const CircleAvatar(
          radius: 18,
          child: Icon(Icons.person),
        //   Image.network(
        //       'https://avatars.githubusercontent.com/u/46148235?s=96&v=4'),
        ),
        title: Text(
          '${AuthUtils.firstName ?? ''} ${AuthUtils.lastName ?? ''}',
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          AuthUtils.email ?? 'Unknown',
          style: const TextStyle(color: Colors.white54),
        ),
        trailing: IconButton(
          onPressed: () async {
            await AuthUtils.clearAuthData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          },
          icon: const Icon(Icons.logout),
          color: Colors.white,
        ),
      ),
    );
  }
}
