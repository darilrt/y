import 'package:flutter/material.dart';
import 'package:y/main/repo/user_repo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  void _onLogin(BuildContext context) {
    UserRepo.login(username, password).then((value) {
      if (value != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
                onChanged: (value) {
                  username = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  _onLogin(context);
                },
                child: const Text('Login'),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
