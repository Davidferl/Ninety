import 'package:bonne_reponse/src/view/home/home.dart';
import 'package:bonne_reponse/src/view/startup/startup.dart';
import 'package:bonne_reponse/src/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/startup',
  routes: [
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const Home(title: "default"),
    ),
    GoRoute(
      name: 'startup',
      path: '/startup',
      builder: (context, state) => const Startup(),
    ),
  ],
);

void main() {
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Bonne réponse!',
      theme: appTheme,
      localizationsDelegates: const [],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
    );
  }
}
