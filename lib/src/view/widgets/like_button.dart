import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onToggle; // Callback to handle state changes externally

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border, // Toggle icon
        color: isLiked ? Colors.red : Colors.black, // Toggle color
      ),
      onPressed: onToggle, // Trigger the external state update
    );
  }
}
