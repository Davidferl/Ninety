import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String imageUrl;
  final bool visited;

  final double imageRadius = 40.0;

  const ProfilePicture({
    super.key,
    required this.imageUrl,
    required this.visited,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: imageRadius,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.grey.shade200,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: visited ? Colors.grey : Colors.green,
                width: 3.0,
              ),
            ),
          ),
        ),
        if (visited)
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  Colors.grey.withOpacity(0.35),
            ),
            width: imageRadius * 2,
            height: imageRadius * 2,
          ),
      ],
    );
  }
}
