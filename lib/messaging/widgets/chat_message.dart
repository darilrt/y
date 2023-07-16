import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, required this.message, required this.isMe})
      : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    const Radius radius = Radius.circular(15);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
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
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
