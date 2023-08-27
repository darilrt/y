import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/models/chat.dart';
import 'package:y/messaging/models/message.dart';
import 'package:y/messaging/repo/message_repo.dart';
import 'package:y/messaging/widgets/chat_message.dart';

import '../widgets/chat_app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.info}) : super(key: key);

  final Chat info;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  void _onSendMessage() {
    if (_messageController.text.isEmpty) {
      return;
    }

    MessageRepo.sendMessage(
      chatId: widget.info.id,
      message: _messageController.text,
    );

    setState(() {
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImage =
        'https://papers.co/wallpaper/papers.co-vy45-digital-dark-square-color-bw-pattern-background-41-iphone-wallpaper.jpg';

    User me = UserRepo.currentUser!;

    String name = widget.info.name;
    String avatar = widget.info.avatar;

    if (!widget.info.isGroup) {
      User otherUser = widget.info.users.firstWhere(
        (element) => element.id != me.id,
      );

      name = otherUser.name;
      avatar = otherUser.avatar;
    }

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
                  child: StreamBuilder<List<Message?>>(
                    stream: MessageRepo.getMessagesStream(widget.info.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Message?> messages = snapshot.data ?? <Message?>[];

                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length + 1,
                          itemBuilder: (context, index) {
                            if (index == messages.length) {
                              return const SizedBox(
                                height: 200,
                              );
                            }

                            Message? message = messages[index];

                            return message != null
                                ? ChatMessage(
                                    message: message,
                                    isMe: message.senderId == me.id,
                                  )
                                : const SizedBox();
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
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
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primary,
                          ),
                          controller: _messageController,
                        ),
                      ),
                      IconButton(
                        onPressed: _onSendMessage,
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
              name: name,
              avatar: avatar,
            ),
          ],
        ),
      ),
    );
  }
}
