class User {
  final String uid;
  final String name;
  final String email;
  final String username;
  final String avatar;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'username': username,
      'avatar': avatar,
    };
  }

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email, username: $username, avatar: $avatar)';
  }
}
