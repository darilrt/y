import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserRepo {
  static User? _currentUser;

  static Future<User?> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final response = await http.get(Uri.parse(
        'https://9a172854-79af-4085-a862-ce12c299c17d.mock.pstmn.io/user'));

    _currentUser = User.fromJson(jsonDecode(response.body));

    return _currentUser;
  }

  static User? logout() {
    _currentUser = null;

    return _currentUser;
  }

  static Future<User?> register(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = User(
      uid: '1234567890',
      name: 'John Doe',
      username: username,
      avatar: 'https://i.pravatar.cc/240',
      email: 'johndoe@example.com',
      emailVerified: false,
      disabled: false,
      lastSignInTime: DateTime.now(),
      creationTime: DateTime.now(),
      lastRefreshTime: DateTime.now(),
      tokensValidAfterTime: DateTime.now(),
    );

    return _currentUser;
  }

  static bool isLogged() {
    return _currentUser != null;
  }

  static User? get currentUser {
    return _currentUser;
  }
}
