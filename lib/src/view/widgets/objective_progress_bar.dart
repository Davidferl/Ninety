import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/group/domain/objective.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:bonne_reponse/src/view/widgets/horizontal_bar_chart.dart';
import 'package:flutter/material.dart';

class ObjectiveProgressBar extends StatelessWidget {
  final Objective objective;
  final double additionalProgress;
  final double height;

  const ObjectiveProgressBar({
    super.key,
    required this.objective,
    this.additionalProgress = 0,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    final double progressRatio = objective.getProgress();
    final double additionalRatio = additionalProgress / objective.quantity;
    final double totalProgress = objective.getTotalProgress();

    return Column(
      children: [
        Text(
            'Your weekly goal for this objective is of ${objective.quantity.round()} ${objective.unit}.',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: kcSecondaryVariant, fontWeight: FontWeight.w500)),
        verticalSpace(10),
        HorizontalBarChart(
          backgroundColor: Colors.grey[300]!,
          height: height,
          segments: [
            Segment(
              color: Colors.green,
              ratio: progressRatio.clamp(0.0, 1),
            ),
            Segment(
              color: Colors.lightGreen,
              ratio: additionalRatio.clamp(0.0, 1 - progressRatio),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Current: ${totalProgress.round()} ${objective.unit}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600], fontWeight: FontWeight.w500)),
              Text(
                  'Additional: ${additionalProgress.round()} ${objective.unit}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600], fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ],
    );
  }
}
