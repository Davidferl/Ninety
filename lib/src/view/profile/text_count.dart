import 'package:flutter/material.dart';
import 'package:bonne_reponse/src/theme/colors.dart';

class TextCount extends StatelessWidget {
  final String name;
  final int count;

  const TextCount({super.key, required this.name, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: kcSecondaryVariant),
        ),
        Text(name,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: kcDarkGray, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
