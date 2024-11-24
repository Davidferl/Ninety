import 'dart:math';

import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/widgets/objective_progress_bar.dart';
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
import 'package:confetti/confetti.dart';

class PagePostProgressLog extends HookWidget {
  final String objectiveId;
  const PagePostProgressLog({super.key, required this.objectiveId});

  @override
  Widget build(BuildContext context) {
    final ConfettiController confettiController = ConfettiController(
      duration: const Duration(seconds: 5),
    );

    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final quantityController = useTextEditingController();
    final selectedImage = useState<XFile?>(null);
    final isSendButtonVisible = useState<bool>(false);
    final additionalProgress = useState<double>(0.0);

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
      return null;
    }, [objectiveId]);

    // Sync visibility of the send button
    useEffect(() {
      void listener() {
        isSendButtonVisible.value = selectedImage.value != null &&
            descriptionController.text.isNotEmpty &&
            quantityController.text.isNotEmpty &&
            titleController.text.isNotEmpty;

        additionalProgress.value =
            double.tryParse(quantityController.text) ?? 0.0;
      }

      titleController.addListener(listener);
      descriptionController.addListener(listener);
      selectedImage.addListener(listener);
      quantityController.addListener(listener);
      return () {
        titleController.removeListener(listener);
        descriptionController.removeListener(listener);
        selectedImage.removeListener(listener);
        quantityController.removeListener(listener);
      };
    }, [
      titleController,
      descriptionController,
      selectedImage,
      quantityController
    ]);

    Future<void> submitForm() async {
      if (objective.value != null && selectedImage.value != null) {
        try {
          final groupId = objective.value!.groupId;
          final memberId = objective.value!.memberId;
          final title = titleController.text;
          final description = descriptionController.text;
          final quantity = double.parse(quantityController.text);

          await groupService.logActivity(groupId, memberId, title, description,
              quantity, selectedImage.value!);
          confettiController.play();
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
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirection: pi / 2,
                  maxBlastForce: 7, // set a lower max blast force
                  minBlastForce: 2, // set a lower min blast force
                  emissionFrequency: 0.02,
                  numberOfParticles: 50, // a lot of particles at once
                  gravity: 1,
                ),
              ),
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
              const Divider(
                color: kcDivider,
                thickness: 1,
              ),
              verticalSpaceSmall,
              if (objective.value != null)
                Text(objective.value!.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: kcPrimaryVariant))
              else
                Text(AppLocalizations.of(context)!.objective),
              const SizedBox(height: 16),
              CustomTextInput(
                textInputAction: TextInputAction.done,
                controller: titleController,
                keyboardType: TextInputType.text,
                labelText: AppLocalizations.of(context)!.title,
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                textInputAction: TextInputAction.done,
                controller: descriptionController,
                keyboardType: TextInputType.text,
                labelText: AppLocalizations.of(context)!.description,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextInput(
                      textInputAction: TextInputAction.done,
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      labelText: AppLocalizations.of(context)!.your_progress,
                    ),
                  ),
                  if (objective.value != null &&
                      objective.value!.quantityType == QuantityType.continuous)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        objective.value!.unit,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              if (objective.value != null)
                ObjectiveProgressBar(
                    objective: objective.value!,
                    additionalProgress: additionalProgress.value),
              const SizedBox(height: 16),
              ImageSelector(
                selectedImage: selectedImage,
              ),
              const Spacer(),
              BottomButton(
                onPressed: isSendButtonVisible.value ? submitForm : null,
                title: AppLocalizations.of(context)!.send,
                isDisabled: !isSendButtonVisible.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
