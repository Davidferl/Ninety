import 'package:bonne_reponse/src/view/addLog/add_photo_card.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class LogProgress extends HookWidget {
  final String title;

  const LogProgress({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final ImagePicker image_picker = ImagePicker();
    final descriptionController = useTextEditingController();

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
              AddPhotoCard(onTap: () => {},)
            ],
          ),
        ),
      ),
    );
  }
}
