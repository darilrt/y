import 'package:firebase_database/firebase_database.dart';
import 'package:y/messaging/models/chat.dart';
import 'package:y/messaging/models/message.dart';
import 'package:y/utils/http.dart';

class MessageRepo {
  static Future<void> sendMessage({
    required int chatId,
    required String message,
  }) async {
    await Http.post(
      '/chats/$chatId/messages',
      body: {
        'message': message,
      },
    );
  }

  static Stream<List<Message>> getMessagesStream(int id) {
    return FirebaseDatabase.instance.ref('chats/$id/messages').onValue.map(
      (event) {
        List<Message> messages = <Message>[];

        if (event.snapshot.exists) {
          messages = Message.fromJsonList(event.snapshot.value as Map);
        }

        return messages;
      },
    );
  }

  static Future<Chat> getChat(int id) async {
    final Map<String, dynamic> data = await Http.get('/chats/$id');

    if (data['error'] != null) {
      throw Exception(data['error']);
    }

    return Chat.fromJson(data);
  }

  static Future<Chat> getChatByUser(int userId) async {
    final Map<String, dynamic> data = await Http.get('/chats/user/$userId');

    if (data['error'] != null) {
      throw Exception(data['error']);
    }

    return Chat.fromJson(data);
  }
}
