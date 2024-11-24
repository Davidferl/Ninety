import 'package:bonne_reponse/src/view/widgets/bottom_button.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/image_selector.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class LogProgress extends HookWidget {
  final String title;
  final Duration photoSnackBarDuration = const Duration(milliseconds: 500);

  const LogProgress({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController();
    final selectedImage = useState<XFile?>(null);
    final isSendButtonVisible = useState<bool>(false);

    // Sync visibility of the send button
    useEffect(() {
      void listener() {
        isSendButtonVisible.value = selectedImage.value != null &&
            descriptionController.text.isNotEmpty;
      }

      descriptionController.addListener(listener);
      selectedImage.addListener(listener);
      return () {
        descriptionController.removeListener(listener);
        selectedImage.removeListener(listener);
      };
    }, [descriptionController, selectedImage]);

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
                    icon: const Icon(Icons.chevron_left, size: 30),
                  ),
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
              ImageSelector(
                selectedImage: selectedImage,
              ),
              const Spacer(),
              if (isSendButtonVisible.value)
                BottomButton(
                  onPressed: () => context.pop(''),
                  title: "Send",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
