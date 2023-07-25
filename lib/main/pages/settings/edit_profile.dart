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

  final DecorationImage _cover = const DecorationImage(
    image: NetworkImage(
      'https://papers.co/wallpaper/papers.co-vy45-digital-dark-square-color-bw-pattern-background-41-iphone-wallpaper.jpg',
    ),
    fit: BoxFit.cover,
  );

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  String? _avatarFile;

  void _onEditAvatar(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    picker.pickImage(source: ImageSource.gallery).then((file) {
      if (file == null) {
        return;
      }

      setState(() {
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

    String? newUrl = _avatarFile;

    if (newUrl != null) {
      StoreRepo.uploadFile(newUrl, 'avatars/${user.id}').then((url) {
        UserRepo.updateUser(
          name: _nameController.text,
          username: _usernameController.text,
        );

        UserRepo.updateAvatar(url);

        setState(() {
          _avatarFile = null;
        });

        Navigator.pop(context);
        Navigator.pop(context);
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
    return StreamBuilder<User?>(
        stream: UserRepo.getUserStream(UserRepo.currentUser!.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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
                        _avatarFile == null
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(snapshot.data!.avatar),
                              )
                            : CircleAvatar(
                                radius: 40,
                                backgroundImage: FileImage(File(_avatarFile!)),
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
        });
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
