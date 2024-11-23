import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int index;

  const Tile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                index % 2 == 0
                    ? 'assets/images/explore_1.jpg'
                    : 'assets/images/explore_3.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sleep earlier',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: kcSecondaryVariant,
                        ),
                  ),
                  verticalSpace(2),
                  Text(
                    'This is a description of the card content.',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: kcSecondaryVariant, fontWeight: FontWeight.w500),
                  ),
                  verticalSpace(12),
                  Row(
                    children: [
                      Text(
                        '100 members',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
