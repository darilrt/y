import 'package:flutter/material.dart';
import 'package:y/utils/login.dart';
import 'package:y/utils/route.dart';
import '../repo/user_repo.dart';
import 'settings/edit_profile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void _onLogout(BuildContext context) {
    UserRepo.logout();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/loading');
  }

  void _onEditProfile(BuildContext context) {
    Login.checkLogin(context);

    Navigator.of(context).push(YPageRoute(
      page: const EditProfilePage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontSize: 16,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(
              'Edit profile',
              style: textStyle,
            ),
            onTap: () {
              _onEditProfile(context);
            },
          ),
          const Divider(
            height: 1,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Log out',
              style: textStyle,
            ),
            onTap: () {
              _onLogout(context);
            },
          ),
        ],
      ),
    );
  }
}
