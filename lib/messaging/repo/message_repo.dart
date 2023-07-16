import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';

import '../models/message.dart';

class MessageRepo {
  static void sendMessage({
    required String chatId,
    required String message,
  }) {
    User me = UserRepo.currentUser!;

    Message newMessage = Message(
      id: _messageIndex.toString(),
      chatId: chatId,
      senderId: me.uid,
      message: message,
      createdAt: DateTime.now(),
    );

    dataMessage.insert(0, newMessage);
    _messageIndex++;
  }

  // Data for testing
  static List<Message> dataMessage = [
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
      createdAt: DateTime.now(),
      message: 'General Kenobi!',
    ),
    Message(
      id: '1',
      message: 'Hello, There!',
      senderId: '1234567890',
      chatId: '1',
      createdAt: DateTime.now(),
    ),
  ];

  static int _messageIndex = 3;
}
