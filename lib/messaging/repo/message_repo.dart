import 'package:firebase_database/firebase_database.dart';
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

  static Stream<List<Message>> getMessagesStream(String id) {
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
}
