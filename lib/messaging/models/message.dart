class Message {
  final String id;
  final String message;
  final String senderId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.message,
    required this.senderId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      senderId: json['senderId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  static List<Message> fromJsonList(Object json) {
    List<Message> messages = [];

    final Map<String, dynamic> data = Map<String, dynamic>.from(json as Map);

    data.forEach((key, value) {
      Map<String, dynamic> res = Map<String, dynamic>.from(value as Map);
      res['id'] = key;

      messages.add(Message.fromJson(res));
    });

    messages.sort((a, b) => -a.createdAt.compareTo(b.createdAt));

    return messages;
  }
}
