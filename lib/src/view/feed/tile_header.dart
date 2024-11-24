import 'package:flutter/material.dart';

class TileHeader extends StatelessWidget {
  final String avatarImageUrl;
  final String username;
  final String teamName;
  final int timeAgo;

  const TileHeader(
      {super.key,
      required this.avatarImageUrl,
      required this.username,
      required this.teamName,
      required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(avatarImageUrl),
        ),
        const SizedBox(width: 6),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text: " in ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: teamName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 15), // Global style for the text
            ),
            Text(
              "$timeAgo mins ago",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),

        const Spacer(),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          onPressed: () {},
        ),
      ],
    );
  }
}
