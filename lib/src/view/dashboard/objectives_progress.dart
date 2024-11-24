import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/widgets/progress_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:bonne_reponse/src/view/widgets/objective_progress_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ObjectivesProgress extends HookWidget {
  const ObjectivesProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final objectives = useState<List<MapEntry<String, Objective>>>([]);
    final isLoading = useState<bool>(true);
    final error = useState<String?>(null);

    final groupService = locator<GroupService>();

    useEffect(() {
      Future<void> fetchObjectives() async {
        try {
          final fetchedObjectives = await groupService.getObjectives();
          objectives.value = fetchedObjectives;
        } catch (e) {
          error.value = AppLocalizations.of(context)!.unknown_error;
        } finally {
          isLoading.value = false;
        }
      }

      fetchObjectives();
      return null;
    }, []);

    if (isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error.value != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 8),
            Text(error.value!),
          ],
        ),
      );
    }

    if (objectives.value.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.no_objectives_found),
      );
    }

    // Replace ListView with a Column wrapped in a SingleChildScrollView
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...objectives.value.map((objective) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          objective.key,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              objective.value.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: kcPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Chip(
                              label: Text(
                                'Goal: ${objective.value.quantity.toInt()} ${objective.value.unit}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              backgroundColor: kcPrimary.withOpacity(0.1),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  ProgressBar2(
                      objective: objective.value,
                      additionalProgress: 0,
                      height: 15,
                      hideProgresses: true),
                  verticalSpace(8)
                ],
              ),
            )),
      ],
    );
  }
}
