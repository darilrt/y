import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/models/chat.dart';

class ChatRepo {
  static Stream<DatabaseEvent> getChatsStream() {
    final DatabaseReference chatsRef = FirebaseDatabase.instance
        .ref('users/${UserRepo.currentUser!.uid}/chats');

    return chatsRef.onValue;
  }

  static Stream<ChatInfo?> getChatInfoStream(String chatId) {
    final DatabaseReference chatRef =
        FirebaseDatabase.instance.ref('chats/$chatId');

    Stream<ChatInfo?> stream = chatRef.onValue.map((event) {
      if (event.snapshot.exists) {
        Map<String, dynamic> dataChatInfo =
            Map<String, dynamic>.from(event.snapshot.value as Map);

        dataChatInfo['id'] = event.snapshot.key;

        return ChatInfo.fromJson(dataChatInfo);
      }

      return null;
    });

    return stream;
  }
}
