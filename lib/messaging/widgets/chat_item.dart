import 'package:flutter/material.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/models/message.dart';
import 'package:y/messaging/pages/chat.dart';
import 'package:y/messaging/repo/message_repo.dart';
import 'package:y/utils/route.dart';

import '../models/chat.dart';

class ChatItem extends StatefulWidget {
  const ChatItem({Key? key, required this.info}) : super(key: key);

  final Chat info;

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  Message? lastMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(YPageRoute(
          page: ChatPage(info: widget.info),
        ));
      },
      title: widget.info.isGroup
          ? buildGroupChat(context)
          : buildUserChat(context),
    );
  }

  String lastMessageTime() {
    if (lastMessage == null) {
      return '';
    }

    final String hour = lastMessage!.createdAt.hour.toString().padLeft(2, '0');
    final String minute =
        lastMessage!.createdAt.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  buildGroupChat(BuildContext context) {
    String messageWrapped = lastMessage != null
        ? lastMessage!.message.length > 30
            ? '${lastMessage!.message.substring(0, 25)}...'
            : lastMessage!.message
        : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          offset: const Offset(0, 0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(widget.info.avatar),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.people_alt_rounded,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.info.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              messageWrapped,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: widget.info.messagesCount > 0
                    ? Colors.blue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                widget.info.messagesCount.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: widget.info.messagesCount > 0
                      ? Colors.white
                      : Colors.transparent,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              lastMessageTime(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildUserChat(BuildContext context) {
    String messageWrapped = lastMessage != null
        ? lastMessage!.message.length > 30
            ? '${lastMessage!.message.substring(0, 25)}...'
            : lastMessage!.message
        : '';

    final otherUser = widget.info.users
        .firstWhere((element) => element.id != UserRepo.currentUser!.id);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(otherUser.avatar),
        ),
        // false
        //     ? Transform.translate(
        //         offset: const Offset(-13, 13),
        //         child: const Icon(
        //           Icons.circle,
        //           size: 15,
        //           color: Colors.green,
        //         ),
        //       )
        //     :
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              otherUser.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              messageWrapped,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: widget.info.messagesCount > 0
                    ? Colors.blue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                widget.info.messagesCount.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: widget.info.messagesCount > 0
                      ? Colors.white
                      : Colors.transparent,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              lastMessageTime(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void getLastMessage() {
    MessageRepo.getMessagesStream(widget.info.id).listen((List<Message> event) {
      if (event.isNotEmpty && mounted) {
        setState(() {
          lastMessage = event.first;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getLastMessage();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
