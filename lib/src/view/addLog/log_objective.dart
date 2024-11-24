import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/group/application/group_service.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/addLog/tile_objective.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogObjective extends HookWidget {
  const LogObjective({super.key});

  @override
  Widget build(BuildContext context) {
    final groupService = locator<GroupService>();

    final objectives = useState<List<MapEntry<String, Objective>>?>(null);
    final isLoading = useState<bool>(true);
    final error = useState<String?>(null);

    useEffect(() {
      Future<void> fetchObjectives() async {
        try {
          final fetchedObjectives = await groupService.getObjectives();
          objectives.value = fetchedObjectives;
        } catch (e) {
          error.value = AppLocalizations.of(context)?.unknown_error;
        } finally {
          isLoading.value = false;
        }
      }

      fetchObjectives();
      return null;
    }, []); // Empty dependency array ensures this runs only once

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionName(name: AppLocalizations.of(context)!.new_log),
            const Divider(
              color: kcDivider,
              thickness: 1,
            ),
            verticalSpaceSmall,
            Text(
              AppLocalizations.of(context)!.pick_objective,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: kcSecondaryVariant,
                  ),
            ),
            Text(
              AppLocalizations.of(context)!.pick_objective_description,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: kcDarkGray,
                  ),
            ),
            verticalSpaceMedium,
            Expanded(
              child: isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : error.value != null
                      ? Center(
                          child: Text(
                            error.value!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        )
                      : (objectives.value == null || objectives.value!.isEmpty)
                          ? Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .no_objectives_found,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : ListView.builder(
                              itemCount: objectives.value!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final objective = objectives.value![index];
                                return Column(
                                  children: [
                                    ObjectiveTile(
                                      imageUri: objective.key,
                                      title: objective.value.title,
                                      description: getLastEntryString(
                                          context,
                                          objective.value
                                              .getLastPostTimestamp()),
                                    ),
                                    verticalSpace(10),
                                  ],
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}

String getLastEntryString(BuildContext context, DateTime? timestamp) {
  if (timestamp == null) {
    return AppLocalizations.of(context)!.no_entry_yet;
  }

  final now = DateTime.now();
  final difference = now.difference(timestamp);

  // If the entry is today
  if (difference.inDays == 0) {
    return AppLocalizations.of(context)!.last_entry_today;
  }

  // If the entry was yesterday
  if (difference.inDays == 1) {
    return AppLocalizations.of(context)!.last_entry_yesterday;
  }

  // If the entry was more than 1 day ago
  return AppLocalizations.of(context)!.last_entry_days_ago(difference.inDays);
}
