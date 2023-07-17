class User {
  final String uid;
  final String name;
  final String email;
  final bool emailVerified;
  final String username;
  final String avatar;
  final bool disabled;
  final DateTime lastSignInTime;
  final DateTime creationTime;
  final DateTime lastRefreshTime;
  final DateTime tokensValidAfterTime;
  final List<String> chats;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.username,
    required this.avatar,
    required this.disabled,
    required this.lastSignInTime,
    required this.creationTime,
    required this.lastRefreshTime,
    required this.tokensValidAfterTime,
    required this.chats,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'] ?? '',
      emailVerified: json['emailVerified'] ?? false,
      username: json['username'],
      avatar: json['avatar'] ??
          'https://firebasestorage.googleapis.com/v0/b/daril-y.appspot.com/o/profiles%2Fdefault.jpg?alt=media&token=4e23040e-5e3f-4972-bd34-5d23acc02f27',
      disabled: json['disabled'] ?? false,
      chats: json['chats'] != null
          ? List<String>.from(json['chats'] as List)
          : <String>[],
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
