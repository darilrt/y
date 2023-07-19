import 'package:flutter/material.dart';

import '../models/user.dart';

class FriendListItem extends StatelessWidget {
  const FriendListItem({Key? key, required this.user, required this.onTap})
      : super(key: key);

  final User user;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      onTap: onTap,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, 0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user.avatar),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '@${user.username}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 30),
                ),
                onPressed: () {
                  // show message dialog to confirm unfriend
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Unfriend"),
                        content: const Text(
                            "Are you sure you want to unfriend this user?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Unfriend"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Friend"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
