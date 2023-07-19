import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:y/messaging/repo/chat_repo.dart';
import 'package:y/messaging/widgets/chat_item.dart';

import '../models/chat.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Messaging'),
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
      body: StreamBuilder<DatabaseEvent>(
        stream: ChatRepo.getChatsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            List<Object?> chats =
                (snapshot.data!.snapshot.value as List<Object?>);

            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                if (chats[index] == null) {
                  return const SizedBox();
                }

                String chatId = chats[index]! as String;

                return StreamBuilder<ChatInfo?>(
                  stream: ChatRepo.getChatInfoStream(chatId),
                  builder: (context, chatInfo) {
                    if (snapshot.hasData) {
                      return chatInfo.data != null
                          ? ChatItem(
                              info: chatInfo.data!,
                            )
                          : const SizedBox();
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No chats yet :\'c',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 99, 99, 99),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
