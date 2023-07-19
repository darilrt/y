import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:y/main/repo/user_repo.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  String? _validateEmail(String? value) {
    final text = value ?? '';

    if (text.isEmpty) {
      return 'Required';
    }

    if (!text.contains('@') || !text.contains('.')) {
      return 'Invalid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    final text = value ?? '';

    if (text.isEmpty) {
      return 'Required';
    }

    if (text.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? _validateUsername(String? value) {
    final text = value ?? '';

    if (text.isEmpty) {
      return 'Required';
    }

    if (text.length < 4) {
      return 'Username must be at least 4 characters';
    }

    if (text.contains(' ')) {
      return 'Username cannot contain spaces';
    }

    return null;
  }

  String? _validateName(String? value) {
    final text = value ?? '';

    if (text.isEmpty) {
      return 'Required';
    }

    if (text.length < 4) {
      return 'Name must be at least 4 characters';
    }

    return null;
  }

  void _onRegister() {
    final String email = _emailController.text;

    if (_validateEmail(email) != null) {
      _emailFocusNode.requestFocus();
      return;
    }

    final String password = _passwordController.text;

    if (_validatePassword(password) != null) {
      _passwordFocusNode.requestFocus();
      return;
    }

    final String username = _usernameController.text;

    if (_validateUsername(username) != null) {
      _usernameFocusNode.requestFocus();
      return;
    }

    final String name = _nameController.text;

    if (_validateName(name) != null) {
      _nameFocusNode.requestFocus();
      return;
    }

    UserRepo.register(
      email,
      password,
      username,
      name,
    ).then((value) {
      if (value == null) {
        ScaffoldMessenger.of(_emailFocusNode.context!).showSnackBar(
          const SnackBar(
            content: Text('Register failed'),
          ),
        );
      } else {
        Navigator.pushReplacementNamed(_emailFocusNode.context!, '/loading');
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(_emailFocusNode.context!).showSnackBar(
        const SnackBar(
          content: Text('Register failed'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  validator: _validateName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameController,
                  autocorrect: false,
                  focusNode: _nameFocusNode,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    // errorText: _emailErrorText,
                  ),
                  validator: _validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  autocorrect: false,
                  focusNode: _emailFocusNode,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: _validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  focusNode: _passwordFocusNode,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'username',
                    prefix: Text('@'),
                  ),
                  validator: _validateUsername,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _usernameController,
                  autocorrect: false,
                  focusNode: _usernameFocusNode,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9]')),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: _onRegister,
                  child: const Text('Register'),
                ),
                const SizedBox(
                  height: 20,
                ),
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
      ),
    );
  }
}
