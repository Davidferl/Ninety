import 'package:flutter/material.dart';

class AddPhotoCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddPhotoCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey[100],
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}