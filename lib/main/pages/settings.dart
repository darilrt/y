import 'package:flutter/material.dart';
import '../repo/user_repo.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void _onLogout(BuildContext context) {
    UserRepo.logout();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/login');
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
