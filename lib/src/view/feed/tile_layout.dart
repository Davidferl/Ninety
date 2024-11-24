import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/view/feed/tile_content.dart';
import 'package:bonne_reponse/src/view/feed/tile_header.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TileHeader(
          avatarImageUrl:
              'https://wallpapers.com/images/featured/cute-aesthetic-profile-pictures-pjfl391j3q0f7rlz.jpg',
          username: 'Jane Doe',
          teamName: 'Sleep Earlier',
          timeAgo: 4,
        ),
        verticalSpaceSmall,
        TileContent(),
      ],
    );
  }
}
