import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/models/chat.dart';
import 'package:y/messaging/models/message.dart';
import 'package:y/messaging/widgets/chat_message.dart';

import '../widgets/chat_app_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key, required this.info}) : super(key: key);

  final ChatInfo info;

  @override
  Widget build(BuildContext context) {
    String backgroundImage =
        'https://papers.co/wallpaper/papers.co-vy45-digital-dark-square-color-bw-pattern-background-41-iphone-wallpaper.jpg';

    User me = UserRepo.currentUser!;

    List<Message> messages = [
      Message(
        id: '3',
        chatId: '1',
        senderId: '1234567890',
        message: 'You are a bold one!',
        createdAt: DateTime.now(),
      ),
      Message(
        id: '2',
        chatId: '1',
        senderId: '2',
        message: 'General Kenobi!',
        createdAt: DateTime.now(),
      ),
      Message(
        id: '1',
        chatId: '1',
        senderId: '1234567890',
        message: 'Hello, There!',
        createdAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: backgroundImage.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(
                    backgroundImage,
                  ),
                  fit: BoxFit.cover,
                )
              : null,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) => ChatMessage(
                      message: messages[index].message,
                      isMe: messages[index].senderId == me.uid,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.send_rounded),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ChatAppBar(
              name: info.name,
              avatar: info.avatar,
            ),
          ],
        ),
      ),
    );
  }
}
