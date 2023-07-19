import 'package:flutter/material.dart';
import 'package:y/messaging/pages/chats.dart';
import '../widgets/navbar.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 1;

  final List<IconData> icons = [
    Icons.person,
    // Icons.search,
    // Icons.apps,
    // Icons.notificatiwwons,
    Icons.message,
  ];

  Widget _buildBody() {
    // TODO: Implement other pages
    switch (icons[_selectedTab]) {
      case Icons.message:
        return const ChatsPage();

      case Icons.search:
        return const Text("Search");

      case Icons.apps:
        return const Text("Apps");

      case Icons.notifications:
        return const Text("Notifications");

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
