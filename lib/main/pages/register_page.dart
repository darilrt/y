import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                'Register',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Register'),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do you have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Login'),
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
