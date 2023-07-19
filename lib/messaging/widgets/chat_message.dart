import 'package:flutter/material.dart';
import 'package:y/messaging/models/message.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, required this.message, required this.isMe})
      : super(key: key);

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(15);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: radius,
              topRight: radius,
              bottomLeft: isMe ? radius : const Radius.circular(0),
              bottomRight: isMe ? const Radius.circular(0) : radius,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Transform.translate(
                offset: Offset(isMe ? 5 : -3, 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${message.createdAt.hour.toString().padLeft(2, '0')}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (isMe) messageStatus(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget messageStatus() {
    return const Icon(
      Icons.done,
      size: 15,
    );
  }
}
