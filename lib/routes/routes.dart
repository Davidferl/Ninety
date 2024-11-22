import 'package:bonne_reponse/src/view/startup/startup.dart';
import 'package:flutter/material.dart';

enum Routes {
  startup,
}

extension RoutesExtension on Routes {
  String get name {
    switch (this) {
      case Routes.startup:
        return '/startup';
    }
  }
}

Map<String, Widget Function(BuildContext)> appRoutes = {
  Routes.startup.name: (context) => const Startup(),
};

