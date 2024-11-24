import 'package:flutter/material.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<Segment> segments; // List of color + ratio segments
  final double height; // Height of the bar
  final Color backgroundColor; // Default color for unused space

  const HorizontalBarChart({
    super.key,
    required this.segments,
    this.height = 20,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the total ratio to determine if bar is fully filled
    final totalRatio =
        segments.fold(0.0, (sum, segment) => sum + segment.ratio);

    //TODO JO broken af
    return Container(
      height: height,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Add each segment with its defined color and ratio
          ...segments.map((segment) {
            return Container(
              width: (segment.ratio * 100).toDouble(), // Width based on ratio
              color: segment.color,
            );
          }).toList(),

          // Add remaining space if total ratio < 1
          if (totalRatio < 1)
            Container(
              width: ((1 - totalRatio) * 100).toDouble(),
              color: backgroundColor,
            ),
        ],
      ),
    );
  }
}

class Segment {
  final Color color;
  final double ratio;

  Segment({required this.color, required this.ratio});
}

