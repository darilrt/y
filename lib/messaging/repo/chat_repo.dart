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

    Stream<ChatInfo?> stream = chatRef.onValue.map((DatabaseEvent event) {
      if (event.snapshot.exists) {
        final dataChatInfo = event.snapshot.value as Map<Object?, dynamic>;

        dataChatInfo['id'] = event.snapshot.key;

        Map<String, dynamic> chatInfo = {};

        dataChatInfo.forEach((key, value) {
          chatInfo[key.toString()] = value;
        });

        return ChatInfo.fromJson(chatInfo);
      }

      return null;
    });

    return stream;
  }
}
