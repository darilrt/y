import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/pages/friends_to_chat.dart';
import 'package:y/messaging/repo/chat_repo.dart';
import 'package:y/messaging/widgets/chat_item.dart';
import 'package:y/utils/login.dart';
import 'package:y/utils/route.dart';

import '../models/chat.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

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
                  page: const FriendsToChat(),
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
                String chatId = me.chats[index].uid;

                return StreamBuilder<DatabaseEvent>(
                  stream: ChatRepo.getChatInfoStream(chatId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.snapshot.value
                          as Map<Object?, dynamic>;

                      Map<String, dynamic> chatInfo = {};

                      data.forEach((key, value) {
                        chatInfo[key.toString()] = value;
                      });

                      String name = chatInfo["name"] ?? 'No name';

                      return Text(name);
                    } else {
                      return const SizedBox();
                    }
                  },
                );
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
