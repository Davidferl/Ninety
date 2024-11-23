import 'package:bonne_reponse/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Tile extends StatelessWidget {
  final String imageUri;
  final String title;
  final String description;

  const Tile(
      {super.key,
      required this.imageUri,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(Routes.progress.name),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              imageUri,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 24.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
