import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bonne_reponse/src/view/addLog/add_photo_card.dart';
import 'package:bonne_reponse/src/view/addLog/photo_card.dart';

class ImageSelector extends HookWidget {
  final ValueNotifier<XFile?> selectedImage;
  final Duration photoSnackBarDuration = const Duration(milliseconds: 500);

  const ImageSelector({
    super.key,
    required this.selectedImage,
  });

  Future<void> requestPermissions() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      await requestPermissions();
      final imagePicker = ImagePicker();
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = pickedFile;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: photoSnackBarDuration,
            content: const Center(child: Text('Image selected')),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: photoSnackBarDuration,
          backgroundColor: Colors.redAccent,
          content: const Center(child: Text('Failed to pick image')),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pickImage(context),
      child: ValueListenableBuilder<XFile?>(
        valueListenable: selectedImage,
        builder: (context, image, child) {
          if (image == null) {
            return AddPhotoCard(onTap: () => pickImage(context));
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: PhotoCard(image: image),
            );
          }
        },
      ),
    );
  }
}
