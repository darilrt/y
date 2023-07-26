import 'package:flutter/material.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/main/widgets/friend_list_item.dart';

import '../models/user.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User me = UserRepo.currentUser!;

    List<User> friends = me.friends;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Friends'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: friends.isEmpty
          ? const Center(
              child: Text(
                'No friends? :\'c\nAdd some!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 99, 99, 99),
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return FriendListItem(
                  onTap: () {},
                  user: friends[index],
                );
              },
            ),
    );
  }
}
