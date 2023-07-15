import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String name = 'Daril Rodriguez';
    const String followers = '1.2k';

    return Container(
      height: 125,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          /* color: Theme.of(context).colorScheme.primary, */),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              'https://ui-avatars.com/api/?name=$name',
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_sharp,
                    size: 20,
                  ),
                  Text(
                    followers,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
