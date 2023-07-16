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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      username: json['username'],
      avatar: json['avatar'],
      disabled: json['disabled'],
      lastSignInTime: DateTime.parse(json['metadata']['lastSignInTime']),
      creationTime: DateTime.parse(json['metadata']['creationTime']),
      lastRefreshTime: DateTime.parse(json['metadata']['lastRefreshTime']),
      tokensValidAfterTime:
          DateTime.parse(json['tokensValidAfterTime'].toString()),
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
