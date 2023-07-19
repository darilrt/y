import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user.dart';
import '../../repo/store_repo.dart';
import '../../repo/user_repo.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserRepo.currentUser!;

  late Image _avatar;

  final DecorationImage _cover = const DecorationImage(
    image: NetworkImage(
      'https://papers.co/wallpaper/papers.co-vy45-digital-dark-square-color-bw-pattern-background-41-iphone-wallpaper.jpg',
    ),
    fit: BoxFit.cover,
  );

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  String? _avatarFile;

  _EditProfilePageState() {
    _avatar = Image.network(
      user.avatar,
      fit: BoxFit.cover,
    );
  }

  void _onEditAvatar(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    picker.pickImage(source: ImageSource.gallery).then((file) {
      if (file == null) {
        return;
      }

      setState(() {
        _avatar = Image.file(
          File(file.path),
          fit: BoxFit.cover,
        );

        _avatarFile = file.path;
      });
    });
  }

  void _onSave(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (_avatarFile != null) {
      StoreRepo.uploadFile(_avatarFile!, 'avatars/${user.uid}').then((url) {
        UserRepo.updateUser(
          name: _nameController.text,
          username: _usernameController.text,
        );

        NetworkImage newAvatar = NetworkImage(url);

        ImageCache().clear();
      });
      return;
    }

    UserRepo.updateUser(
      name: _nameController.text,
      username: _usernameController.text,
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget buildBanner(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            image: _cover,
          ),
          height: 130,
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: _avatar.image,
                  ),
                  Positioned(
                    bottom: -11,
                    right: -13,
                    child: TextButton(
                      onPressed: () {
                        _onEditAvatar(context);
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(0, 0),
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        ),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                      ),
                      child: const Icon(
                        size: 20,
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -25,
          right: 40,
          child: TextButton(
            onPressed: () {
              _onEditAvatar(context);
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                const Size(0, 0),
              ),
              padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(10, 5, 10, 5),
              ),
              shape: MaterialStateProperty.all(
                const CircleBorder(),
              ),
              backgroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
            ),
            child: const Icon(
              size: 20,
              Icons.photo_size_select_actual_rounded,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoForm(BuildContext context) {
    User user = UserRepo.currentUser!;

    _nameController.text = user.name;
    _usernameController.text = user.username;

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                controller: _nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                controller: _usernameController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Edit Profile'),
      ),
      body: Column(
        children: [
          buildBanner(context),
          buildInfoForm(context),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    Colors.red,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  ),
                ),
                onPressed: () {
                  _onSave(context);
                },
                child: const Text('Save'),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
