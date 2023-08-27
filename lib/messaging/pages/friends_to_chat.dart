import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/pages/chat.dart';
import 'package:y/messaging/repo/message_repo.dart';
import 'package:y/utils/login.dart';
import 'package:y/utils/route.dart';

class FriendsToChat extends StatelessWidget {
  const FriendsToChat({Key? key}) : super(key: key);

  void _onTap(BuildContext context, User user) {
    MessageRepo.getChatByUser(user.id).then((chat) {
      Navigator.of(context).push(
        YPageRoute(
          page: ChatPage(
            info: chat,
          ),
        ),
      );
    }).onError((error, stackTrace) {});
  }

  @override
  build(BuildContext context) {
    Login.checkLogin(context);

    User me = UserRepo.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Select a friend to chat'),
      ),
      body: ListView.builder(
        itemCount: me.friends.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(me.friends[index].avatar),
            ),
            title: Text(me.friends[index].name),
            subtitle: Text('@${me.friends[index].username}'),
            onTap: () {
              _onTap(context, me.friends[index]);
            },
          );
        },
      ),
    );
  }
}
