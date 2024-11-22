import 'package:bonne_reponse/src/view/home/home.dart';
import 'package:bonne_reponse/src/view/startup/startup.dart';
import 'package:bonne_reponse/src/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Startup();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'home',
            name: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const Home(title: 'Home');
            })
      ]),
]);

void main() {
  runApp(DevicePreview(
    enabled: true,
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
