import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoCard extends StatelessWidget {
  final XFile image;

  const PhotoCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
      child: Image.file(
        File(image.path),
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
