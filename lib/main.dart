import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/authentication/views/login.dart';
import 'package:bonne_reponse/src/startup/views/startup.dart';
import 'package:bonne_reponse/src/view/home/home.dart';
import 'package:bonne_reponse/src/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

enum Routes { home, startup, login }

final _router = GoRouter(
  initialLocation: '/startup',
  routes: [
    GoRoute(
      name: Routes.home.name,
      path: '/home',
      builder: (context, state) => const Home(title: "default"),
    ),
    GoRoute(
      name: Routes.startup.name,
      path: '/startup',
      builder: (context, state) => const Startup(),
    ),
    GoRoute(
      name: Routes.login.name,
      path: '/login',
      builder: (context, state) => const Login(),
    )
  ],
);

// TODO add useful stuff from last year's main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
