import 'package:firebase_database/firebase_database.dart';
import 'package:y/main/models/user.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/models/message.dart';

class MessageRepo {
  static void sendMessage({
    required String chatId,
    required String message,
  }) {
    User me = UserRepo.currentUser!;

    final DatabaseReference messagesRef =
        FirebaseDatabase.instance.ref('chats/$chatId/messages');

    messagesRef.push().set({
      'message': message,
      'senderId': me.id,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
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
