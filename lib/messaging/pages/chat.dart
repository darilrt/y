import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/models/chat.dart';
import 'package:y/messaging/models/message.dart';
import 'package:y/messaging/repo/message_repo.dart';
import 'package:y/messaging/widgets/chat_message.dart';

import '../repo/chat_repo.dart';
import '../widgets/chat_app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.info}) : super(key: key);

  final ChatInfo info;

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
                                    isMe: message.senderId == me.uid,
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
            StreamBuilder<ChatInfo?>(
              stream: ChatRepo.getChatInfoStream(widget.info.id),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  ChatInfo info = snapshot.data!;

                  if (info.isGroup) {
                    return ChatAppBar(
                      name: info.name,
                      avatar: info.avatar,
                    );
                  }

                  final otherUserId = info.users.firstWhere(
                    (element) => element != me.uid,
                  );

                  return StreamBuilder<User?>(
                    stream: UserRepo.getUserStream(otherUserId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        User user = snapshot.data!;

                        return ChatAppBar(
                          name: user.name,
                          avatar: user.avatar,
                        );
                      } else {
                        return const ChatAppBar(
                          name: '',
                          avatar:
                              'https://firebasestorage.googleapis.com/v0/b/daril-y.appspot.com/o/profiles%2Fdefault.jpg?alt=media&token=4e23040e-5e3f-4972-bd34-5d23acc02f27',
                        );
                      }
                    },
                  );
                } else {
                  return const ChatAppBar(
                    name: '',
                    avatar:
                        'https://firebasestorage.googleapis.com/v0/b/daril-y.appspot.com/o/profiles%2Fdefault.jpg?alt=media&token=4e23040e-5e3f-4972-bd34-5d23acc02f27',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
