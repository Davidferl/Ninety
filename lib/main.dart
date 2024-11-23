import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/view/authentication/login.dart';
import 'package:bonne_reponse/src/view/authentication/register.dart';
import 'package:bonne_reponse/src/view/startup/startup.dart';
import 'package:bonne_reponse/src/view/home/home.dart';
import 'package:bonne_reponse/src/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

enum Routes { home, startup, login, signup }

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
    ),
    GoRoute(
      name: Routes.signup.name,
      path: "/signup",
      builder: (context, state) => const Register(),
    ),
  ],
);

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
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Bonne réponse!',
      theme: appTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
      ],
    );
  }
}
