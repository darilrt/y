import '../models/chat.dart';

class ChatRepo {
  static List<ChatInfo> getChats() {
    return chats;
  }

  static List<ChatInfo> chats = [
    ChatInfo(
      id: '1',
      name: 'Darlene Robertson',
      avatar: 'https://i.pravatar.cc/240#0',
      lastMessage: 'Hello 👋',
      lastMessageTime: DateTime.now(),
      isOnline: true,
    ),
    ChatInfo(
      id: '2',
      name: 'Daril Rodriguez',
      avatar: 'https://i.pravatar.cc/240#1',
      lastMessage: 'Hello',
      lastMessageTime: DateTime.now(),
      isOnline: false,
    ),
    ChatInfo(
      id: '3',
      name: 'Jon Maquin',
      avatar: 'https://i.pravatar.cc/240#2',
      lastMessage: 'Hello',
      lastMessageTime: DateTime.now(),
      isOnline: true,
    ),
    ChatInfo(
      id: '4',
      name: 'Pamela Anderson',
      avatar: 'https://i.pravatar.cc/240#3',
      lastMessage: 'Hello',
      lastMessageTime: DateTime.now(),
      isOnline: false,
    ),
  ];
}
