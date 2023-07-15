import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.add,
    Icons.person,
  ];

  Widget _buildBody() {
    switch (_selectedTab) {
      case 0:
        return const Text("Home"); // TODO: Implement home page

      case 1:
        return const Text("Search"); // TODO: Implement search page

      case 2:
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
