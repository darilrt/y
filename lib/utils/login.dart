import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main/repo/user_repo.dart';

class Login {
  static Future<void> checkLogin(BuildContext context,
      {Function()? onLogged}) async {
    UserRepo.isLogged().then((value) {
      if (value) {
        if (onLogged != null) {
          onLogged();

          FirebaseMessaging.instance.getToken().then((token) {
            UserRepo.updateFcmToken(token!);
          });

          FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
}
