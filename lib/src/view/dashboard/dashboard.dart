import 'package:bonne_reponse/src/view/dashboard/analytics_section.dart';
import 'package:bonne_reponse/src/view/dashboard/misc_stats_section.dart';
import 'package:bonne_reponse/src/view/dashboard/objectives_progress.dart';
import 'package:bonne_reponse/src/view/dashboard/statistics_section.dart';
import 'package:bonne_reponse/src/view/widgets/section_name.dart';
import 'package:bonne_reponse/src/view/widgets/subsection_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dashboard extends HookWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionName(name: AppLocalizations.of(context)!.dashboard),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubsectionName(
                        name: AppLocalizations.of(context)!.analytics),
                    const AnalyticsSection(),
                    const SizedBox(height: 12),
                    SubsectionName(
                        name: AppLocalizations.of(context)!.your_progress),
                    const ObjectivesProgress(),
                    const SizedBox(height: 4),
                    SubsectionName(
                        name: AppLocalizations.of(context)!.statistics),
                    const MiscStatsSection(),
                    const CategoriesStatsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
