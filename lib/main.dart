import 'package:bonne_reponse/injection_container.dart';
import 'package:bonne_reponse/src/view/addLog/page_post_progress_log.dart';
import 'package:bonne_reponse/src/group/domain/group.dart';
import 'package:bonne_reponse/src/view/authentication/login.dart';
import 'package:bonne_reponse/src/view/authentication/register.dart';
import 'package:bonne_reponse/src/view/explore/group_viewer.dart';
import 'package:bonne_reponse/src/view/feed/group/group_page.dart';
import 'package:bonne_reponse/src/view/startup/startup.dart';
import 'package:bonne_reponse/src/view/home/home.dart';
import 'package:bonne_reponse/src/theme/theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/view/profile/settings.dart';

enum Routes {
  home,
  startup,
  login,
  signup,
  progress,
  groupViewer,
  settings,
  feed
}

final _router = GoRouter(
  initialLocation: '/startup',
  routes: [
    GoRoute(
        name: Routes.home.name,
        path: '/home',
        builder: (context, state) {
          return const Home();
        },
        routes: [
          GoRoute(
            name: Routes.progress.name,
            path: "/progress/:objectiveId", // Change path to use objectiveId
            builder: (context, state) {
              final String objectiveId =
                  state.pathParameters['objectiveId']!; // Access objectiveId
              return PagePostProgressLog(
                  objectiveId: objectiveId); // Pass objectiveId to the page
            },
          ),
          GoRoute(
            name: Routes.feed.name,
            path: "/feed/:groupId",
            builder: (context, state) {
              final String groupId = state.pathParameters['groupId']!;
              Group group = state.extra as Group;
              return GroupPage(group: group, groupId: groupId);
            },
          ),
          GoRoute(
            name: Routes.groupViewer.name,
            path: "/groupViewer",
            builder: (context, state) {
              Group group = state.extra as Group;
              return GroupViewer(group: group);
            },
          ),
          GoRoute(
            name: Routes.settings.name,
            path: "/settings",
            builder: (context, state) => const Settings(),
          ),
        ]),
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final token = await FirebaseMessaging.instance.getToken();

  print("FirebaseMessaging token: $token");

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
