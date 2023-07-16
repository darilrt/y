import 'package:flutter/material.dart';
import 'package:y/messaging/pages/chats.dart';
import '../widgets/navbar.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 2;

  final List<IconData> icons = [
    Icons.person,
    // Icons.search,
    Icons.apps,
    // Icons.notificatiwwons,
    Icons.message,
  ];

  Widget _buildBody() {
    switch (icons[_selectedTab]) {
      case Icons.message:
        return const ChatsPage();

      case Icons.search:
        return const Text("Search"); // TODO: Implement search page

      case Icons.apps:
        return const Text("Apps"); // TODO: Implement apps page

      case Icons.notifications:
        return const Text(
            "Notifications"); // TODO: Implement notifications page

      case Icons.person:
        return const ProfilePage();

      default:
        return const Center(
          child: Text('Unknown page'),
        );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: NavBar(
        icons: icons,
        onChange: _onItemTapped,
      ),
    );
  }
}
