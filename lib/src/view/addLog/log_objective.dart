import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/addLog/tile_objective.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogObjective extends HookWidget {
  const LogObjective({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        const Tile(
                          imageUri: "assets/images/explore_3.jpg",
                          title: "Sleep at 9pm",
                          description: "Last entry yesterday",
                        ),
                        verticalSpace(10),
                      ],
                    );
                  },
                ))
              ],
            )));
  }
}
