import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class BottomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? color;
  final bool? isDisabled;

  const BottomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color,
    this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: screenWidth(context),
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: isDisabled != null && isDisabled!
                ? kcPrimaryVariant
                : kcOnPrimary,
            backgroundColor: isDisabled != null && isDisabled!
                ? kcDivider
                : color ?? kcPrimary,
            minimumSize: Size(screenWidth(context), 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kcOnPrimary),
          ),
          onPressed: isDisabled != null && isDisabled! ? null : onPressed,
          child: Text(
            title.toUpperCase(),
          )),
    );
  }
}
