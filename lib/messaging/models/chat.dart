import 'package:y/main/models/user.dart';
import 'package:y/messaging/models/message.dart';

class Chat {
  final int id;
  final String uid;
  final String name;
  final String avatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isOnline;
  final bool isGroup;
  final int messagesCount;
  final List<Message> messages;
  final List<User> users;

  const Chat({
    required this.id,
    required this.uid,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
    required this.messages,
    this.isGroup = false,
    this.messagesCount = 0,
    this.users = const <User>[],
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    final List<Message> messages = json['messages'] != null
        ? Message.fromJsonList(json['messages'])
        : <Message>[];

    final Message? lastMessage = messages.isNotEmpty ? messages.first : null;

    List<User> users = [];
    json['users'].forEach((value) {
      users.add(User.fromJson(value));
    });

    return Chat(
      id: json['id'],
      uid: json['uid'],
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? 'https://i.pravatar.cc/240',
      lastMessage: lastMessage != null ? lastMessage.message : '',
      lastMessageTime:
          lastMessage != null ? lastMessage.createdAt : DateTime.now(),
      isOnline: json['isOnline'] ?? false,
      messages: messages,
      messagesCount: json['messagesCount'] ?? 0,
      isGroup: json['isGroup'],
      users: users,
    );
  }
}
