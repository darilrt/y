import 'package:flutter/material.dart';
import 'package:y/main/pages/friend_list.dart';
import 'package:y/utils/login.dart';
import 'package:y/utils/route.dart';
import '../models/user.dart';
import '../pages/settings.dart';
import '../repo/user_repo.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  Widget buildBanner(BuildContext context) {
    User user = UserRepo.currentUser!;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                user.cover,
              ),
              fit: BoxFit.cover,
            ),
          ),
          height: 140,
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: const Offset(0, 72),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                    user.avatar,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 125,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  '@${user.username}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white30,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),

        // Friends
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 40),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    YPageRoute(
                      page: const FriendListPage(),
                    ),
                  );
                },
                child: Text(
                  'Friends (${getFriendCount(user.friends.length)})',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                YPageRoute(
                  page: const SettingsPage(),
                ),
              );

              Login.checkLogin(context);
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: buildBanner(context),
    );
  }

  String getFriendCount(int length) {
    if (length < 1000) {
      return length.toString();
    } else if (length < 1000000) {
      return '${(length / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(length / 1000000).toStringAsFixed(1)}M';
    }
  }
}
