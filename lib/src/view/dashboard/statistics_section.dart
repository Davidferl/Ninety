import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesStatsSection extends StatelessWidget {
  const CategoriesStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                  text: AppLocalizations.of(context)!
                      .stats_habit_becomes_lifestyle_prefix,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: kcSecondaryVariant),
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.stats_habit,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!
                          .stats_habit_becomes_lifestyle_middle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: kcSecondaryVariant,
                          ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.stats_lifestyle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 16),

            // Ratios and categories in rows
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CategoryProgress(
                      ratio: "67/90",
                      category: AppLocalizations.of(context)!.stats_sleep,
                    ),
                    _CategoryProgress(
                      ratio: "12/90",
                      category: AppLocalizations.of(context)!.stats_nutrition,
                    ),
                    _CategoryProgress(
                      ratio: "38/90",
                      category: AppLocalizations.of(context)!.stats_physical,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CategoryProgress(
                      ratio: "28/90",
                      category: AppLocalizations.of(context)!.stats_balance,
                    ),
                    _CategoryProgress(
                      ratio: "0/90",
                      category: AppLocalizations.of(context)!.stats_social,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryProgress extends StatelessWidget {
  final String ratio;
  final String category;

  const _CategoryProgress({
    required this.ratio,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: kcDarkGray,
              ),
        ),
        Text(
          ratio,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
