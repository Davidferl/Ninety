import 'package:flutter/material.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<Segment> segments;
  final double height;
  final Color backgroundColor;

  const HorizontalBarChart({
    super.key,
    required this.segments,
    this.height = 20,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 24;
    
    // Calculate the total ratio to determine if bar is fully filled
    final totalRatio =
        segments.fold(0.0, (sum, segment) => sum + segment.ratio);

    return Container(
      height: height,
      width: width,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Add each segment with its defined color and ratio
          ...segments.map((segment) {
            return Container(
              width: (segment.ratio * width).toDouble(),
              color: segment.color,
            );
          }),

          // Add remaining space if total ratio < 1
          if (totalRatio < 1)
            Container(
              width: ((1 - totalRatio) * width).toDouble(),
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
