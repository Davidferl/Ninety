import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AnalyticsSection extends StatelessWidget {
  const AnalyticsSection({super.key});
  // warning : ton objectif xyz est à risque cette semaine
  // x personnes t'ont envoyé des encouragements
  // tu as un streak de x semaines pour ton objectif abc

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading:
                  const Icon(Icons.warning_amber_rounded, color: Colors.orange),
              title: Text(
                AppLocalizations.of(context)!.objective_at_risk(
                    "Course à pied" // TODO fetch one of user's objectives
                    ),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: kcSecondaryVariant, fontWeight: FontWeight.w500),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              leading: const Icon(Icons.favorite_rounded, color: Colors.pink),
              title: Text(
                AppLocalizations.of(context)!.encouragement_received(3),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: kcSecondaryVariant, fontWeight: FontWeight.w500),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              leading: const Icon(Icons.local_fire_department_rounded,
                  color: Colors.deepOrange),
              title: Text(
                AppLocalizations.of(context)!.objective_streak(
                    AppLocalizations.of(context)!.demo_objective_jogging, 4),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: kcSecondaryVariant, fontWeight: FontWeight.w500),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
