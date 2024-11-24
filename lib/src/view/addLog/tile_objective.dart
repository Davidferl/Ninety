import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/main.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ObjectiveTile extends StatelessWidget {
  final String imageUri;
  final String objectiveId;
  final String title;
  final String description;

  const ObjectiveTile(
      {super.key,
      required this.imageUri,
      required this.objectiveId,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .goNamed(Routes.progress.name, pathParameters: {"objectiveId": objectiveId}),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              imageUri,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: kcSecondaryVariant,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: kcDarkGray, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 24.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
