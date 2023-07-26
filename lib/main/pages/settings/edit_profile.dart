import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user.dart';
import '../../repo/user_repo.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserRepo.currentUser!;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  String? _avatarFile;
  String? _coverFile;

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

  void _onEditCover(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    picker.pickImage(source: ImageSource.gallery).then((file) {
      if (file == null) {
        return;
      }

      setState(() {
        _coverFile = file.path;
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

    if (_avatarFile != null || _coverFile != null) {
      UserRepo.update(
        name: _nameController.text,
        username: _usernameController.text,
        avatar: _avatarFile,
        cover: _coverFile,
      ).then((value) {
        setState(() {
          _avatarFile = null;
          _coverFile = null;

          Navigator.pop(context);
          Navigator.pop(context);
        });
      }).onError((error, stackTrace) {
        setState(() {
          _avatarFile = null;
          _coverFile = null;

          Navigator.pop(context);
          Navigator.pop(context);
        });

        showAboutDialog(context: context, children: [
          Text("Error updating profile, please try later. $error"),
        ]);
      });

      return;
    }

    UserRepo.update(
      name: _nameController.text,
      username: _usernameController.text,
    ).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  Widget buildBanner(BuildContext context) {
    User user = UserRepo.currentUser!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            image: _coverFile == null
                ? DecorationImage(
                    image: NetworkImage(user.cover),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: FileImage(File(_coverFile!)),
                    fit: BoxFit.cover,
                  ),
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
                          backgroundImage: NetworkImage(user.avatar),
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
          bottom: 3,
          right: 10,
          child: TextButton(
            onPressed: () {
              _onEditCover(context);
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
