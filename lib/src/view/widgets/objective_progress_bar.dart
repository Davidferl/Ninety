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
    final double progressRatio = objective.getProgress() / objective.quantity;
    final double additionalRatio = additionalProgress / objective.quantity;

    // Ensure the combined ratio does not exceed 1
    final double totalRatio = (progressRatio + additionalRatio).clamp(0.0, 1.0);

    return HorizontalBarChart(
      height: height,
      segments: [
        //TODO JO use real values
        Segment(
          color: Colors.lightGreen,
          ratio: 0.4//progressRatio,//.clamp(0.0, totalRatio),
        ),
        Segment(
          color: Colors.green,
          ratio: 0.3//additionalRatio,//.clamp(0.0, totalRatio - progressRatio),
        ),
      ],
    );
  }
}
