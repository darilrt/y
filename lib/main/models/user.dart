import '../constants/user.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final bool emailVerified;
  final String username;
  final String avatar;
  final String cover;
  final bool disabled;
  final DateTime lastSignInTime;
  final DateTime creationTime;
  final DateTime lastRefreshTime;
  final List<String> chats;
  final List<String> friends;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.username,
    required this.avatar,
    required this.cover,
    required this.disabled,
    required this.lastSignInTime,
    required this.creationTime,
    required this.lastRefreshTime,
    required this.chats,
    required this.friends,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> chats = [];
    List<String> friends = [];

    if (json['chats'] != null) {
      final data = json["chats"] as Map<Object?, dynamic>;

      data.forEach((key, value) {
        chats.add(value as String);
      });
    }

    if (json['friends'] != null) {
      final data = json["friends"] as Map<Object?, dynamic>;

      data.forEach((key, value) {
        friends.add(value as String);
      });
    }

    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'] ?? '',
      emailVerified: json['emailVerified'] ?? false,
      username: json['username'],
      avatar: json['avatar'] ?? UserConstants.avatarDefault,
      cover: json['cover'] ?? UserConstants.coverDefault,
      disabled: json['disabled'] ?? false,
      friends: friends,
      chats: chats,
      lastSignInTime: DateTime.now(),
      creationTime: DateTime.now(),
      lastRefreshTime: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    return 'User(uid: $uid, username: @$username)';
  }
}
