class Message {
  final String id;
  final String message;
  final String senderId;
  final String chatId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.message,
    required this.senderId,
    required this.chatId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['text'],
      senderId: json['senderId'],
      chatId: json['chatId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': message,
      'senderId': senderId,
      'chatId': chatId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
