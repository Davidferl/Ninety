import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';

class PostHeader extends StatelessWidget {
  final String userImageUrl;
  final String username;
  final String groupName;
  final String timeAgo;

  const PostHeader(
      {super.key,
      required this.userImageUrl,
      required this.username,
      required this.groupName,
      required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    const colorPalette =
        BoringAvatarPalette([kcPrimary, kcSecondaryVariant, kcLightPrimary]);

    return Row(
      children: [
        CircleAvatar(
          child: BoringAvatar(
              palette: colorPalette,
              shape: const OvalBorder(),
              name: userImageUrl,
              type: BoringAvatarType.beam),
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
                    text: groupName,
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
              timeAgo,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
