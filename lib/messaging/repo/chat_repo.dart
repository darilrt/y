import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:y/main/repo/user_repo.dart';
import 'package:y/messaging/models/chat.dart';

class ChatRepo {
  static Stream<DatabaseEvent> getChatsStream() {
    final DatabaseReference chatsRef = FirebaseDatabase.instance
        .ref('users/${UserRepo.currentUser!.id}/chats');

    return chatsRef.onValue;
  }

  static Stream<DatabaseEvent> getChatInfoStream(String chatId) {
    final DatabaseReference chatRef =
        FirebaseDatabase.instance.ref('chats/$chatId');

    return chatRef.onValue;
  }
}
