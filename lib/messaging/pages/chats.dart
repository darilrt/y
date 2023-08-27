import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/pages/friends_to_chat.dart';
import 'package:y/messaging/widgets/chat_item.dart';
import 'package:y/utils/login.dart';
import 'package:y/utils/route.dart';

import '../models/chat.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    Login.checkLogin(context);

    User me = UserRepo.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Messaging'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                YPageRoute(
                  page: FriendsToChat(
                    onChatCreated: () {
                      setState(() {});
                    },
                  ),
                  orientation: AnimationOrientation.topToBottom,
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: me.chats.isNotEmpty
          ? ListView.builder(
              itemCount: me.chats.length,
              itemBuilder: (context, index) {
                Chat chat = me.chats[index];
                return ChatItem(info: chat);
              },
            )
          : const Center(
              child: Text(
                'No chats yet :\'c',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 99, 99, 99),
                ),
              ),
            ),
    );
  }
}
