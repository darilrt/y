import 'package:flutter/material.dart';
import 'package:y/messaging/repo/chat_repo.dart';
import 'package:y/messaging/widgets/chat_item.dart';

import '../models/chat.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatInfo> chats = ChatRepo.getChats();

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
      body: ListView.builder(
        itemExtent: 85,
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatItem(
          info: chats[index],
        ),
      ),
    );
  }
}
