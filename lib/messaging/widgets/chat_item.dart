import 'package:flutter/material.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/pages/chat.dart';
import 'package:y/utils/route.dart';

import '../models/chat.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.info}) : super(key: key);

  final ChatInfo info;

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
    return Text(
      info.name,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }

  buildUserChat(BuildContext context) {
    String messageWrapped = info.lastMessage.length > 30
        ? info.lastMessage.substring(0, 25)
        : info.lastMessage;

    if (info.lastMessage.length > 30) messageWrapped += '...';

    final otherUserId = info.users
        .firstWhere((element) => element != UserRepo.currentUser!.uid);

    return StreamBuilder<User?>(
        stream: UserRepo.getUserStream(otherUserId),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lastMessageTime(info.lastMessageTime),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  info.messagesCount > 0
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            info.messagesCount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          );
        });
  }
}
