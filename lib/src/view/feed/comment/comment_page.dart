import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CommentPage extends HookWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
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
