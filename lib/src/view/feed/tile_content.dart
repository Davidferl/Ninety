import 'package:bonne_reponse/src/theme/colors.dart';
import 'package:flutter/material.dart';

class TileContent extends StatelessWidget {
  const TileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
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
                'assets/images/explore_1.jpg',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Sleep before 9pm",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: kcSecondaryVariant),
                      ),
                      Text(
                        "Third day in a row",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: kcSecondaryVariant),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 125,
                        child: Text(
                          "Feeling so good after todays breakfast!",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: kcSecondaryVariant),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
