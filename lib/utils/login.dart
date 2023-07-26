import 'package:flutter/material.dart';

import '../main/repo/user_repo.dart';

class Login {
  static Future<void> checkLogin(BuildContext context,
      {Function()? onLogged}) async {
    UserRepo.isLogged().then((value) {
      if (value) {
        if (onLogged != null) {
          onLogged();
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
}
