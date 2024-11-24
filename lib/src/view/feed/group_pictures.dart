import 'package:flutter/material.dart';

class GroupPictures extends StatelessWidget {
  final String imageUrl;
  final String groupId;
  final bool visited = false;

  final double imageRadius = 35.0;

  const GroupPictures({
    super.key,
    required this.imageUrl,
    required this.groupId,
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
              color: Colors.grey.withOpacity(0.35),
            ),
            width: imageRadius * 2,
            height: imageRadius * 2,
          ),
      ],
    );
  }
}
