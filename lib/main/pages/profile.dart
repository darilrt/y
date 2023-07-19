import 'package:flutter/material.dart';
import 'package:y/main/pages/friend_list.dart';
import 'package:y/utils/route.dart';
import '../models/user.dart';
import '../pages/settings.dart';
import '../repo/user_repo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget buildBanner(BuildContext context) {
    return StreamBuilder<User?>(
        stream: UserRepo.getUserStream(UserRepo.currentUser!.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          User user = snapshot.data!;

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  user.cover,
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              YPageRoute(
                                page: const FriendListPage(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            minimumSize: const Size(0, 0),
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                getFriendCount(user.friends.length),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
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
