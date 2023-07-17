import 'package:flutter/material.dart';
import 'package:y/utils/route.dart';
import '../models/user.dart';
import '../pages/settings.dart';
import '../repo/user_repo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = UserRepo.currentUser!;

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
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://papers.co/wallpaper/papers.co-vy45-digital-dark-square-color-bw-pattern-background-41-iphone-wallpaper.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: 130,
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                user.avatar,
              ),
            ),
            const SizedBox(
              width: 20,
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
                Text(
                  '@${user.username}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white30,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        size: 20,
                      ),
                      label: const Text('1.2k'),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(0, 30),
                        padding: const EdgeInsets.all(5),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
