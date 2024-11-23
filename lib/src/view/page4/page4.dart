import 'package:bonne_reponse/src/view/widgets/custom_auto_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Page4 extends HookWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return Scaffold(
      body: CustomAutocomplete(
          textEditingController: textEditingController,
          options: const ["Option 1", "Option 2"]),
    );
  }
}
