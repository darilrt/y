import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import '../models/user.dart';

class UserRepo {
  static User? _currentUser;

  static User? get currentUser {
    return _currentUser;
  }

  static Future<User?> login(String email, String password) async {
    try {
      final auth.UserCredential userCredential =
          await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _currentUser = await UserRepo.getUser(userCredential.user!.uid);

      if (_currentUser == null) {
        throw Exception('No user found for that email.');
      }

      return _currentUser;
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception(e.message);
      }
    }
  }

  static User? logout() {
    auth.FirebaseAuth.instance.signOut();
    _currentUser = null;
    return _currentUser;
  }

  static Future<User?> register(String username, String password) async {
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
      chats: [],
    );

    return _currentUser;
  }

  static Future<bool> isLogged() async {
    if (auth.FirebaseAuth.instance.currentUser != null) {
      _currentUser =
          await UserRepo.getUser(auth.FirebaseAuth.instance.currentUser!.uid);
    } else {
      _currentUser = null;
    }

    return _currentUser != null;
  }

  static Future<User?> getUser(String uid, {Function? callback}) async {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.ref('users/$uid');

    final DataSnapshot snapshot = await userRef.get();

    if (callback != null) {
      snapshot.ref.onValue.listen((event) {
        if (event.snapshot.exists) {
          Map<String, dynamic> data =
              Map<String, dynamic>.from(event.snapshot.value as Map);

          data['uid'] = event.snapshot.key;

          User user = User.fromJson(data);

          callback(user);
        }
      });
    }

    if (snapshot.exists) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(snapshot.value as Map);

      data['uid'] = uid;

      User user = User.fromJson(data);

      return user;
    }

    return null;
  }

  static Stream<User?> getUserStream(String otherUserId) {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.ref('users/$otherUserId');

    return userRef.onValue.map((event) {
      if (event.snapshot.exists) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(event.snapshot.value as Map);

        data['uid'] = event.snapshot.key;

        return User.fromJson(data);
      }

      return null;
    });
  }
}
