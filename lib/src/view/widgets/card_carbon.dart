import 'package:animated_digit/animated_digit.dart';
import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';

class CardCarbon extends StatelessWidget {
  final int score;
  final double _borderRadius = 20.0;

  const CardCarbon({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: screenHeightFraction(context, dividedBy: 3),
            width: screenWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              image: const DecorationImage(
                  image:
                      AssetImage('assets/images/carbon_score_background.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedDigitWidget(
                    value: score,
                    textStyle: const TextStyle(
                        color: kcSecondary,
                        fontSize: 72.0,
                        fontWeight: FontWeight.w800),
                  ),
                  const Text(
                    "TODO CHANGE ME",
                    style: TextStyle(
                        color: kcPrimaryVariant,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
          )),
    );
  }
}
