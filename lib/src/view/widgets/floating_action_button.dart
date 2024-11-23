import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class GradientFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;

  const GradientFloatingActionButton(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [kcLightPrimary, kcPrimary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        FloatingActionButton(
          onPressed: onPressed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          child: icon,
        ),
      ],
    );
  }
}

