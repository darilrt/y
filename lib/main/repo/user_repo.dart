import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:y/utils/http.dart';
import '../models/user.dart';

const storage = FlutterSecureStorage();

class UserRepo {
  static User? _currentUser;

  static User? get currentUser {
    return _currentUser;
  }

  static Future<User?> login(String email, String password) async {
    Http.setBearerToken('');

    Map<String, dynamic> res = await Http.post(
      '/auth/signin',
      body: {
        'email': email,
        'password': password,
      },
    );

    if (res['error'] != null) {
      throw Exception(res['error']);
    }

    Http.setBearerToken(res['token'] as String);
    final Map<String, dynamic> data = (await Http.get('/users/me'));

    storage.write(key: 'auth_token', value: res['token']);

    _currentUser = User.fromJson(data);
    return _currentUser;
  }

  static User? logout() {
    Http.post('/auth/signout');

    Http.setBearerToken('');
    storage.delete(key: 'auth_token');

    _currentUser = null;
    return _currentUser;
  }

  static Future<User?> register(
      String email, String password, String username, String name) async {
    Http.setBearerToken('');

    Map<String, dynamic> res = await Http.post(
      '/auth/signup',
      body: {
        'email': email,
        'password': password,
        'username': username,
        'name': name,
      },
    );

    if (res['error'] != null) {
      throw Exception(res['error']);
    }

    Http.setBearerToken(res['token'] as String);
    final Map<String, dynamic> data = (await Http.get('/users/me'));

    _currentUser = User.fromJson(data);

    return _currentUser;
  }

  static Future<bool> isLogged() async {
    String? token = await storage.read(key: 'auth_token');
    if (token != null) {
      Http.setBearerToken(token);
      final Map<String, dynamic> data = (await Http.get('/users/me'));

      if (data['error'] != null) {
        return false;
      }

      _currentUser = User.fromJson(data);
    } else {
      _currentUser = null;
    }

    return _currentUser != null;
  }

  static Future<User?> getUser(String uid) async {
    final Map<String, dynamic> data = await Http.get('/users/$uid');

    if (data['error'] != null) {
      throw Exception(data['error']);
    }

    return User.fromJson(data);
  }

  static Stream<User?> getUserStream(int otherUserId) {
    final data = Http.get('/users/$otherUserId');

    return data.asStream().map((event) {
      if (event['error'] != null) {
        throw Exception(event['error']);
      }

      return User.fromJson(event);
    });
  }

  static Stream<List<int>> getFriendsStream(int id) {
    return const Stream<List<int>>.empty();
  }

  static void updateAvatar(String value) {}

  static void updateUser({required String name, required String username}) {}
}
