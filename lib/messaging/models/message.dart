class Message {
  final String id;
  final String message;
  final int senderId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.message,
    required this.senderId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    int senderId = 0;

    if (json.containsKey('senderId') && json['senderId'].runtimeType == int) {
      senderId = json['senderId'];
    }

    DateTime createdAt = DateTime.now();

    if (json.containsKey('createdAt') &&
        json['createdAt'].runtimeType == String) {
      createdAt = DateTime.parse(json['createdAt']).toLocal();
    }

    return Message(
      id: json['id'],
      message: json['message'],
      senderId: senderId,
      createdAt: createdAt,
    );
  }

  static List<Message> fromJsonList(Object json) {
    List<Message> messages = [];

    final Map<String, dynamic> data = Map<String, dynamic>.from(json as Map);

    data.forEach((key, value) {
      Map<String, dynamic> res = {
        'id': key,
      };

      value.forEach((key, value) {
        res[key.toString()] = value;
      });

      messages.add(Message.fromJson(res));
    });

    messages.sort((a, b) => -a.createdAt.compareTo(b.createdAt));

    return messages;
  }
}
