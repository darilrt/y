import 'package:flutter/material.dart';
import 'package:y/main/pages/friend_list.dart';
import 'package:y/utils/route.dart';

import '../models/user.dart';
import '../repo/user_repo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isFriend = false;

  @override
  void initState() {
    super.initState();

    for (var friend in UserRepo.currentUser!.friends) {
      if (friend.id == widget.user.id) {
        setState(() {
          _isFriend = true;
        });
      }
    }
  }

  void _requestFriend() {
    UserRepo.requestFriend(widget.user.id).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Friend request sent'),
        ),
      );

      setState(() {
        _isFriend = true;
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }

  void _removeFriend() {
    setState(() {
      _isFriend = false;
    });
  }

  String _getFriendCount(int length) {
    if (length < 1000) {
      return length.toString();
    } else if (length < 1000000) {
      return '${(length / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(length / 1000000).toStringAsFixed(1)}M';
    }
  }

  Widget _buildBanner(BuildContext context) {
    User user = widget.user;

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
                onPressed: () {
                  Navigator.of(context).push(
                    YPageRoute(
                      page: const FriendListPage(),
                    ),
                  );
                },
                child: Text(
                  'Friends (${_getFriendCount(user.friends.length)})',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (!_isFriend)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 40),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: _requestFriend,
                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                ),
              if (_isFriend)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(40, 40),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: _removeFriend,
                  child: const Icon(
                    Icons.person_remove,
                    color: Colors.white,
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
        title: Text(widget.user.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildBanner(context),
        ],
      ),
    );
  }
}
