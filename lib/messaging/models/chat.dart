class ChatInfo {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isOnline;
  final int messagesCount = 0;

  const ChatInfo({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
  });

  factory ChatInfo.fromJson(Map<String, dynamic> json) {
    return ChatInfo(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      lastMessage: json['lastMessage'],
      lastMessageTime: DateTime.parse(json['lastMessageTime']),
      isOnline: json['isOnline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'isOnline': isOnline,
    };
  }
}
