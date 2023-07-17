import 'package:y/messaging/models/message.dart';

class ChatInfo {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isOnline;
  final bool isGroup;
  final int messagesCount;
  final List<Message> messages;
  final List<String> users;

  const ChatInfo({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
    required this.messages,
    this.isGroup = false,
    this.messagesCount = 0,
    this.users = const <String>[],
  });

  factory ChatInfo.fromJson(Map<String, dynamic> json) {
    final List<Message> messages = json['messages'] != null
        ? Message.fromJsonList(json['messages'])
        : <Message>[];

    final Message? lastMessage = messages.isNotEmpty ? messages.last : null;

    if (json['users'] != null && json['users'].length <= 2) {}

    return ChatInfo(
      id: json['id'],
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? 'https://i.pravatar.cc/240',
      lastMessage: lastMessage != null ? lastMessage.message : '',
      lastMessageTime:
          lastMessage != null ? lastMessage.createdAt : DateTime.now(),
      isOnline: json['isOnline'] ?? false,
      messages: messages,
      messagesCount: json['messagesCount'] ?? 0,
      isGroup: json['users'] != null && json['users'].length > 2,
      users: json['users'] != null
          ? List<String>.from(json['users'] as List)
          : <String>[],
    );
  }
}
