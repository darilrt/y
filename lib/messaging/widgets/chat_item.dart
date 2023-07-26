import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/pages/chat.dart';
import 'package:y/utils/route.dart';

import '../models/chat.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.info}) : super(key: key);

  final Chat info;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(YPageRoute(
          page: ChatPage(info: info),
        ));
      },
      title: info.isGroup ? buildGroupChat(context) : buildUserChat(context),
    );
  }

  String lastMessageTime(DateTime lastMessageTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(lastMessageTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return '${difference.inSeconds}s';
    }
  }

  buildGroupChat(BuildContext context) {
    String messageWrapped = info.lastMessage.length > 30
        ? info.lastMessage.substring(0, 25)
        : info.lastMessage;

    if (info.lastMessage.length > 30) messageWrapped += '...';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          offset: const Offset(0, 0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(info.avatar),
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
                  info.name,
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
                color:
                    info.messagesCount > 0 ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                info.messagesCount.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: info.messagesCount > 0
                      ? Colors.white
                      : Colors.transparent,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              lastMessageTime(info.lastMessageTime),
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
    String messageWrapped = info.lastMessage.length > 30
        ? info.lastMessage.substring(0, 25)
        : info.lastMessage;

    if (info.lastMessage.length > 30) messageWrapped += '...';

    final otherUserId =
        info.users.firstWhere((element) => element != UserRepo.currentUser!.id);

    return StreamBuilder<User?>(
        stream: UserRepo.getUserStream(1),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          User otherUser = snapshot.data!;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0, 0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(otherUser.avatar),
                ),
              ),
              info.isOnline
                  ? Transform.translate(
                      offset: const Offset(-13, 13),
                      child: const Icon(
                        Icons.circle,
                        size: 15,
                        color: Colors.green,
                      ),
                    )
                  : const SizedBox(
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
                      color: info.messagesCount > 0
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      info.messagesCount.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: info.messagesCount > 0
                            ? Colors.white
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    lastMessageTime(info.lastMessageTime),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
