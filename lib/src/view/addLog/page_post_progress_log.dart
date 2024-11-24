import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:bonne_reponse/src/view/widgets/bottom_button.dart';
import 'package:bonne_reponse/src/view/widgets/custom_text_input.dart';
import 'package:bonne_reponse/src/view/widgets/image_selector.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PagePostProgressLog extends HookWidget {
  final String objectiveId;
  const PagePostProgressLog({super.key, required this.objectiveId});

  @override
  Widget build(BuildContext context) {
    final descriptionController = useTextEditingController();
    final quantityController = useTextEditingController();
    final selectedImage = useState<XFile?>(null);
    final isSendButtonVisible = useState<bool>(false);

    final objective = useState<Objective?>(null);
    final isLoading = useState<bool>(true);
    final error = useState<String?>(null);

    final groupService = locator<GroupService>();

    useEffect(() {
      Future<void> fetchObjective() async {
        try {
          final fetchedObjective =
              await groupService.getObjectiveById(objectiveId);
          objective.value = fetchedObjective;
        } catch (e) {
          error.value = AppLocalizations.of(context)!.unknown_error;
        } finally {
          isLoading.value = false;
        }
      }

      fetchObjective();
    }, [objectiveId]);

    // Sync visibility of the send button
    useEffect(() {
      void listener() {
        isSendButtonVisible.value = selectedImage.value != null &&
            descriptionController.text.isNotEmpty &&
            quantityController.text.isNotEmpty;
      }

      descriptionController.addListener(listener);
      selectedImage.addListener(listener);
      quantityController.addListener(listener);
      return () {
        descriptionController.removeListener(listener);
        selectedImage.removeListener(listener);
        quantityController.removeListener(listener);
      };
    }, [descriptionController, selectedImage, quantityController]);

    // Submit the form
    Future<void> submitForm() async {
      if (objective.value != null && selectedImage.value != null) {
        try {
          final groupId = objective.value!.groupId;
          final memberId = objective.value!.memberId;
          final title = objective.value!.title;
          final description = descriptionController.text;
          final quantity = double.parse(quantityController.text);
          final imageFile = File(selectedImage.value!.path);

          await groupService.logActivity(
              groupId, memberId, title, description, quantity, imageFile);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Activity logged successfully')),
          );
          context.pop();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to log activity')),
          );
        }
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
                    icon: const Icon(Icons.chevron_left, size: 30),
                  ),
                  const SectionName(name: 'Log progress'),
                  IconButton(
                      onPressed: () => {}, icon: const Icon(Icons.more_horiz))
                ],
              ),
              if (objective.value != null)
                Text(objective.value!.title)
              else
                Text(AppLocalizations.of(context)!.objective),
              CustomTextInput(
                textInputAction: TextInputAction.done,
                controller: descriptionController,
                keyboardType: TextInputType.text,
                labelText: "How it went...",
              ),
              CustomTextInput(
                textInputAction: TextInputAction.done,
                controller: quantityController,
                keyboardType: TextInputType.number,
                labelText: "Quantity",
              ),
              ImageSelector(
                selectedImage: selectedImage,
              ),
              const Spacer(),
              if (isSendButtonVisible.value)
                BottomButton(
                  onPressed: submitForm,
                  title: "Send",
                ),
            ],
          ),
        ),
      ),
    );
  }
}
