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
  final DateTime tokensValidAfterTime;
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
    required this.tokensValidAfterTime,
    required this.chats,
    required this.friends,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> chats = [];
    List<String> friends = [];

    if (json['chats'] != null) {
      chats = List<String>.from(json['chats']);
    }

    if (json['friends'] != null) {
      friends = List<String>.from(json['friends']);
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
      tokensValidAfterTime: DateTime.now(), // TODO: Parse from json
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'username': username,
      'avatar': avatar,
      'disabled': disabled,
      'metadata': {
        'lastSignInTime': lastSignInTime.toIso8601String(),
        'creationTime': creationTime.toIso8601String(),
        'lastRefreshTime': lastRefreshTime.toIso8601String(),
      },
      'tokensValidAfterTime': tokensValidAfterTime.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'User(uid: $uid, username: @$username)';
  }
}
