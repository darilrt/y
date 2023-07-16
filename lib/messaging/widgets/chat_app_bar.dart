import 'dart:ui';

import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({Key? key, required this.name, required this.avatar})
      : super(key: key);

  final String name;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        blendMode: BlendMode.srcIn,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).padding.top + 56,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 4,
              ),
              Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(avatar),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.more_vert),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
