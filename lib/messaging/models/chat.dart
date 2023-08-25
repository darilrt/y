import 'package:y/main/models/user.dart';

class Chat {
  final int id;
  final String uid;
  final String name;
  final String avatar;
  final bool isGroup;
  final int messagesCount;
  final List<User> users;

  const Chat({
    required this.id,
    required this.uid,
    required this.name,
    required this.avatar,
    this.isGroup = false,
    this.messagesCount = 0,
    this.users = const <User>[],
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    List<User> users = [];
    json['users'].forEach((value) {
      users.add(User.fromJson(value));
    });

    return Chat(
      id: json['id'],
      uid: json['uid'],
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? 'https://i.pravatar.cc/240',
      messagesCount: json['messagesCount'] ?? 0,
      isGroup: json['isGroup'],
      users: users,
    );
  }
}
