import 'package:bonne_reponse/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../hooks/use_startup.dart';

class Startup extends HookWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context) {
    useStartup();

    return Scaffold(
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
        color: const Color.fromARGB(255, 51, 114, 15),
        child: const Center(),
      ),
    );
  }
}
