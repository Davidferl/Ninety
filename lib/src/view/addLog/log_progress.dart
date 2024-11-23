import 'package:bonne_reponse/src/view/addLog/add_photo_card.dart';
import 'package:bonne_reponse/src/view/addLog/photo_card.dart';
import 'package:bonne_reponse/src/view/widgets/bottom_button.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class LogProgress extends HookWidget {
  final String title;
  final Duration photoSnackBarDuration = const Duration(milliseconds: 500);

  const LogProgress({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    final descriptionController = useTextEditingController();
    final selectedImage = useState<XFile?>(null);
    final isSendButtonVisible = useState<bool>(false);

    Future<void> requestPermissions() async {
      if (await Permission.photos.isDenied) {
        await Permission.photos.request();
      }
      if (await Permission.camera.isDenied) {
        await Permission.camera.request();
      }
    }

    useEffect(() {
      void listener() {
        isSendButtonVisible.value = selectedImage.value != null &&
            descriptionController.text.isNotEmpty;
      }

      descriptionController.addListener(listener);
      selectedImage.addListener(listener);
      return () => {
            descriptionController.removeListener(listener),
            selectedImage.removeListener(listener)
          };
    }, [descriptionController, selectedImage]);

    Future<void> pickImage() async {
      try {
        await requestPermissions();
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          selectedImage.value = pickedFile;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: photoSnackBarDuration,
                content: const Center(child: Text('Image selected'))),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: photoSnackBarDuration,
              backgroundColor: Colors.redAccent,
              content: const Center(child: Text('Failed to pick image'))),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => context.pop(''),
                      icon: const Icon(Icons.chevron_left, size: 30)),
                  const SectionName(name: 'Log progress'),
                  IconButton(
                      onPressed: () => {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
              Text(title),
              CustomTextInput(
                textInputAction: TextInputAction.done,
                controller: descriptionController,
                keyboardType: TextInputType.text,
                labelText: "How it went...",
              ),
              if (selectedImage.value == null)
                AddPhotoCard(
                  onTap: () => pickImage(),
                )
              else
                GestureDetector(
                  onTap: () => pickImage(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: PhotoCard(
                      image: selectedImage.value!,
                    ),
                  ),
                ),
              const Spacer(),
              if (isSendButtonVisible.value)
                BottomButton(
                  onPressed: () => context.pop(''),
                  title: "Send",
                )
            ],
          ),
        ),
      ),
    );
  }
}
