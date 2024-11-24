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

  const ObjectiveTile({
    super.key,
    required this.imageUri,
    required this.objectiveId,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
  final index = GoRouter.of(context).state?.pathParameters['index'];
  context.goNamed(
    Routes.progress.name,
    pathParameters: {
      "objectiveId": objectiveId,
      "index": index!, 
    },
  );
},

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              imageUri,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.red,
                );
              },
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
