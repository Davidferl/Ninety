import 'package:bonne_reponse/src/group/domain/objective.dart';
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

    return HorizontalBarChart(
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
    );
  }
}
